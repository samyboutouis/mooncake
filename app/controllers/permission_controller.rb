class PermissionController < ApplicationController

    def addmorepermnum
        @list = []
        @course = Course.find(params[:course])
        @list.append(@course.id)
        for id in @course.cross_listing
            @list.append(id)
        end
      end

    def addmore
        course = Course.find(params[:course]) 
        file = params[:file]
        file_upload(file, course.id)
        if course.primary == false 
            redirect_to numbers_path(course.cross_listing[0])
        else
            redirect_to numbers_path(course)
        end
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
        request.update(permission_number: permnum)
        permnum.update(used: true)
        redirect_to numbers_path(course)
    end

end
