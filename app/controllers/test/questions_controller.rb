class Test::QuestionsController < ApplicationController
  before_action :set_test
  before_action :set_test_questions
  before_action :set_question, only: [:edit, :show, :update, :destroy, :response]


  respond_to :html, :json

  def index
    @questions = Question.all
    respond_with(@test, @questions)
  end

  def show
    respond_with(@test, @question)
  end

  def url_options
    {test_id: params[:test_id] }.merge(super)
  end

  def response
    if @test.can_show_response?(@question)
      respond_with(@test, @question)
    else
      redirect_back_or_to path: authenticated_root_path
    end
  end

  private

  def set_test
    @test = current_user.tests.find(params[:test_id])
  end

  def set_test_questions
    @test_questions = @test.questions
  end

  def set_question
    @question = @test_questions.find(params[:id])
  end

  def question_params
    params[:question]
  end
end
