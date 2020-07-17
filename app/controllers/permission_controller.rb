class PermissionController < ApplicationController

    def addmorepermnum
        @course = Course.find(params[:course])
      end

    def addmore
        course = Course.find(params[:course]) #CourseRequest.find(params[:request]).course
        file = params[:file]
        #@request = CourseRequest.find(params[:request])
        xlsx = Roo::Spreadsheet.open(file)
            sheet = xlsx.sheet(0)
            z=0
            sheet.each do |row|
            if z>0
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
                course.permission_numbers.create(number: row[0].to_i, expire_date: row[7], used: false, consent: consent, capacity: capacity, reqs: reqs)
                end
            end
            z += 1
            end
        redirect_to numbers_path(course)
    end

    def numbers
        @course = Course.find(params[:course])
    end

    def assignman
      @user = User.find(params[:net_id])
    end

    def assign_num
        course = Course.find(params[:course])
        permission_number = params[:permnum]
        permnum = PermissionNumber.find(permission_number)
        user = User.find(params[:user_id])
        request = CourseRequest.find_by(course_id: course, user_id: user)
        
        #permnum.course_request.update(course_request: request)
        request.update(permission_number: permnum)
        permnum.update(used: true)
    
        
        redirect_to numbers_path(course)
        # term = params[:term]
        # @course = Course.where(term: term, published: true)
        # respond_to do |format|
        #     format.json {render json: @course}
        # end
        
    end

end
