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
end