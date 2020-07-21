module DashboardHelper
    def perm_no(request)
        if request.permission_number != nil
            "PermNo: " + request.permission_number.number.to_s + " (expires on " + request.permission_number.expire_date.to_s + ")"
        end
    end
end