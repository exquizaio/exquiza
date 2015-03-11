class TestTaking::QuestionsController < ApplicationController
  layout "test_taking"
  before_action :set_test
  before_action :set_test_questions
  before_action :set_question

  respond_to :html
  def show
    if @test.position > @test.questions.size
      redirect_to complete_test_taking_test_path(@test)
    else
      respond_with(@test, @question.decorate)
    end
  end

  def url_options
    {test_id: params[:test_id] }.merge(super)
  end

  def respond
    @test.new_response(@question, response_params)
    redirect_to test_taking_test_question_path(@test, @test.next_question)
  end

  private

  def set_test
    @test = current_user.tests.find(params[:test_id]).decorate
  end

  def set_test_questions
    @test_questions = @test.questions
  end

  def set_question
    @question = @test_questions[params[:id].to_i - 1]
  end

  def question_params
    #params.require(:question).permit(:prompt,, :tag_list, prompt_attributes: [:id, :value], choices_attributes: [ :value]
  end

  def response_params
    params.require(:response).permit(:selected_choice_id)
  end
end
