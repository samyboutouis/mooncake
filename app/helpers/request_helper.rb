module RequestHelper
    def active_request(request)
        if request.status == 'Under Review'
            return '<div id="circle" class="circle persimmon"></div>'.html_safe
        elsif request.status == 'Denied'
            return '<div class="circle red"></div>'.html_safe
        else
            return '<div class="circle green"></div>'.html_safe
        end
    end

    def no_request(user)
        if user.course_requests.length() == 0
            return '<p>You have no active permission number requests</p>'.html_safe
        else
            return nil
        end
    end
end