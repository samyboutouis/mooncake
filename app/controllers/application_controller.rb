require "roo"
require "roo-xls"


class ApplicationController < ActionController::Base
    before_action :require_login
    add_flash_types :req
    # before_action :faculty_check
    # before_action :student_check

    private

    def require_login
      redirect_to app_login_path unless session[:user_id]
    end

    def file_upload(file, courseid)
      extension = File.extname(file)
      course = Course.find(courseid)
      if(extension == ".xlsx")
        xlsx = Roo::Spreadsheet.open(file)
        sheet = xlsx.sheet(0)
        z=0
        sheet.each do |row|
          if z>0
            makeFirstPermissionNums(row, course)
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
              makeFirstPermissionNums(row, course)
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
            makeFirstPermissionNums(row, course)
          end
          File.delete('output.csv')
        end
      else
        flash[:alert3] = "You uploaded an invalid file. You can only upload an excel file from DukeHub."
        course.destroy
      end
    end

    def makeFirstPermissionNums(row, course)

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


    # def faculty_check
    #   if session[:current_user]["user_type"] == "student"
    #     redirect_to root_path
    #   end
    # end

    # def student_check
    #   if session[:current_user]["user_type"] == "faculty" || session[:current_user]["user_type"] == "staff"
    #     redirect_to faculty_page_path
    #   end
    # end

    # def checkexpire(yo)
    #   heyy = Course.find(yo)
    #   datee = []
    #   courseunused = heyy.permission_numbers.where(used: false)
    #   for ew in courseunused
    #     datee.append(ew.expire_date)
    #   end
    #   #alldatee = datee.map { |date| Date.strptime(date) } # [Wed, 22 Jan 2020, Wed, 22 Jan 2020, Wed, 22 Jan 2020]
    #   for numberdate in datee
    #     datetimedate = Date.strptime(numberdate)
    #     if Date.today >= datetimedate #expired
    #       stringnumber = datetimedate.to_s
    #       expiredboi = courseunused.where(expire_date: stringnumber)
    #       for nummm in expiredboi
    #         nummm.expired = true
    #       end
    #     end
    #   end
    # end
    #   #end check


end
