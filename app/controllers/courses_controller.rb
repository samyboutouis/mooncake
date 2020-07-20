require "roo"
require "roo-xls"
require "httparty"
class CoursesController < ApplicationController
  # skip_before_action :student_check
  def course_params
    params.require(:course).permit(:term, :department, :course_number, :section_number, :capacity, prereqs_attributes: [:name])
  end

  def new
    @course = Course.new
    @prereqs = @course.prereqs.build
    key = ENV["ACCESS_TOKEN"]
    response0 = HTTParty.get("https://streamer.oit.duke.edu/curriculum/list_of_values/fieldname/SUBJECT?access_token=" + key)
    subjects = JSON.parse(response0.body)
    subjects = subjects["scc_lov_resp"]["lovs"]["lov"]["values"]["value"]
    departments = []
    for sub in subjects
        departments.append(sub["code"] + " - " + sub["desc"])
    end
    @departments = departments
    @terms = [Date.today.year.to_s+" Spring", Date.today.year.to_s+" Summer1", Date.today.year.to_s+" Summer2", Date.today.year.to_s+" Fall", (Date.today.year+1).to_s+" Spring", (Date.today.year+1).to_s+" Summer1", (Date.today.year+1).to_s+" Summer2", (Date.today.year+1).to_s+" Fall"]
  end

  def create
    @user = User.find_by(net_id: session[:current_user]["net_id"])
    if @user.courses.where(term: params[:course][:term], department: params[:course][:department], course_number: params[:course][:course_number], section_number: params[:course][:section_number]).exists?
        flash[:alert2] = "The course you tried to create already exists. You can only create this course if the original one is deleted"
        redirect_to faculty_page_url and return
    elsif course = Course.create(course_params)
      rec = course
      courses = []
      courses.append(course.id)
      course.published = false
      course.primary = true
      course.seats_taken = 0
      @user.courses << course  
      file = params[:course][:file]
      fileUpload(file, course)
      prereqs_attributes = params["prereq_attributes"]
      prereqs_attributes.each do |name|
        if name[1]["name"] != ""
          prereqs = course.prereqs.create(name: name[1]["name"])
        end
      end
      
      j = 0 #????
      cl = Array.new
      hasCrossList = false;
      numAdditionalCrossList = params["number-choice"].to_i
      numAdditionalSections = params["number-choice-sec"].to_i
      if (numAdditionalCrossList>0)
        hasCrossList = true 
      end  

      currentCrossList = 1
      if (hasCrossList)
        while (currentCrossList < numAdditionalCrossList +1)
          dep = "department" + currentCrossList.to_s
          num = "course_number" + currentCrossList.to_s
          file = "file" + currentCrossList.to_s
          Course.create(term: course.term, department: params[dep], course_number: params[num],
          section_number: course.section_number, primary: false, seats_taken: 0, capacity: course.capacity, cross_listing: [course.id])
          cl.append(Course.last.id)
          Course.last.prereqs << course.prereqs
          file = params[file]
          fileUpload(file, Course.last)
          currentCrossList += 1
          course.update(cross_listing: cl)
        end

        j = 1
        while (j < (numAdditionalSections) +1)
          currentCrossList=1
          cl = Array.new
          sec = "section_number" + j.to_s
          capacity = "section_capacity" + j.to_s
          while (currentCrossList <= numAdditionalCrossList+1)
            if currentCrossList == 1
              # n = params["number-choice"].to_i
              file = "file" + (j*(numAdditionalCrossList+2)+currentCrossList).to_s
              course = Course.create(term: course.term, department: course.department, course_number: course.course_number,
              section_number: params[sec], primary: true, seats_taken: 0, capacity: params[capacity], cross_listing: [], published: false)
              User.find_by(net_id: session[:current_user]["net_id"]).courses << Course.last
            else
              dep = "department" + (currentCrossList-1).to_s
              num = "course_number" + (currentCrossList-1).to_s
              b = j*(numAdditionalCrossList+2)+currentCrossList
              file = "file" + b.to_s
              Course.create(term: course.term, department: params[dep], course_number: params[num],
              section_number: params[sec], primary: false, seats_taken: 0, capacity: params[capacity], cross_listing: [course.id])
            end  
            if currentCrossList != 1
              cl.append(Course.last.id)
            end  
            Course.last.prereqs << course.prereqs
            file = params[file]
            fileUpload(file, Course.last)
            currentCrossList += 1
            course.update(cross_listing: cl)
          end 
          j += 1 
        end
      end
      j = 1
      if (!hasCrossList)
        while (j < numAdditionalSections +1)
          sec = "section_number" + j.to_s
          file = "file" + j.to_s
          cap = "section_capacity" + j.to_s
          Course.create(term: course.term, department: course.department, course_number: course.course_number,
          section_number: params[sec], primary: true, seats_taken: 0, capacity: params[cap], cross_listing: [], published: false)
          Course.last.prereqs << course.prereqs
          User.find_by(net_id: session[:current_user]["net_id"]).courses << Course.last
          file = params[file]
          fileUpload(file, Course.last)
          j += 1
        end
      end  
      course = rec
      #UserMailer.with(user: @user, course: course).course_created.deliver_now
      redirect_to question_path(course), alert: "Course created successfully."
    else
      redirect_to faculty_page_url, alert: "Error creating course."
    end
  end

  def delete
    id = params[:id]
    course = Course.find(id)
    course.cross_listing.each do |id|
      Course.destroy(id)
    end
    course.destroy
    redirect_to faculty_page_url
  end

  def departments
    key = ENV["ACCESS_TOKEN"]
    response0 = HTTParty.get("https://streamer.oit.duke.edu/curriculum/list_of_values/fieldname/SUBJECT?access_token=" + key)
    subjects = JSON.parse(response0.body)
    subjects = subjects["scc_lov_resp"]["lovs"]["lov"]["values"]["value"]
    departments = []
    for sub in subjects
        departments.append(sub["code"] + " - " + sub["desc"])
    end
    respond_to do |format|
      format.json {render json: departments}
    end
  end

  def makePermissionNums(row, course)
    unless row[0] == nil
      consent = false
      reqs = false
      capacity = false
      if row[8] == "Y"
        capacity = true
      end
      if row[9] == "Y"
        reqs = true
      end
      if row[10] == "Y"
        consent = true
      end

      numExists = false
      course.cross_listing.each do |course|
        if PermissionNumber.exists?(number: row[0].to_i) 
          numExists = true
        else
        end
      end

      if numExists == false
        course.permission_numbers.create(number: row[0].to_i, expire_date: row[7], used: false, consent: consent, capacity: capacity, reqs: reqs)
      else
      end
    end
  end

  def fileUpload(file, course)
    extension = File.extname(file)
    if(extension == ".xlsx")
      xlsx = Roo::Spreadsheet.open(file)
      sheet = xlsx.sheet(0)
      z=0
      sheet.each do |row|
        if z>0
          makePermissionNums(row, course)
        end
        z += 1
      end
    elsif(extension == ".xls")
      begin
        xlsx = Roo::Spreadsheet.open(file)
        sheet = xlsx.sheet(0)
        z=0
        sheet.each do |row|
          if z>0
            makePermissionNums(row, course)
          end
          z += 1
        end
      rescue StandardError => e
        doc = Nokogiri::HTML(file)
        csv = CSV.open("output.csv", 'w')
        doc.xpath('//table//tr').each do |row|
            tarray = [] #temporary array
            row.xpath('td').each do |cell|
                tarray << cell.text #Build array of that row of data.
            end
            csv << tarray #Write that row out to csv file
        end
        csv.close
        CSV.foreach("output.csv", :headers => true) do |row|
          makePermissionNums(row, course)
        end
        File.delete('output.csv')
      end
    else
      flash[:alert3] = "You uploaded an invalid file. You can only upload an excel file from DukeHub."
      course.cross_listing.each do |id|
        Course.destroy(id)
      end
      course.destroy
      redirect_to new_course_url and return
    end
  end
  end