class DashboardController < ApplicationController

#Student side 

  def index
    @user = User.find_by(net_id: $current_user.net_id)
    $course_request = @user.course_requests
  end

  def withdraw
    # Answer.destroy(Answer.where(course_request: params[:request]))
    CourseRequest.destroy(params[:request])
    redirect_to root_path
  end

  def view 
    @course_request = CourseRequest.find(params[:request])
  end


# Faculty side

  def faculty_index
    @user = $current_user
    @courses = @user.courses.all
  end

  def facreqview
    @course = Course.first
    @course_request = @course.course_requests
    @answer = @course_request.answers.order(:answer_text)





    # list = []
    # for request in @course_request do
    #   h = {}
    #   for question in request.questions do
    #     ans = request.answers.find_by(question_id: question.id).answer_text
    #     h[question.question_text] = ans
    #   end
    #   list.append(h)
    # end

    # @list = list
    # sort = params[:sort]
    # sort = nil unless sort.in?(['distance', 'name', 'price', 'price desc', 'review'])
    # @course_request = CourseRequest.oAnswer.order(sort)
    # @question = @course.questions
    # if params.include?("question_text")
    #   @question = @course.questions.find_by(question_text: params[:question_text])
    # end
  end


#@question = @course.questions.find_by(question_text: "Major:")
  
  def sort  
  end

  # private
  # def sort_column
  #   CourseRequest.first.questions.pluck(:question_text).include?(params[:sort]) ? params[:sort] : "Grad Year"
  # end
  
  # def sort_direction
  #   %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  # end

end