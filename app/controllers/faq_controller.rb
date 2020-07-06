class FaqController < ApplicationController
    skip_before_action :faculty_check
    skip_before_action :student_check
    def show

    end
end    