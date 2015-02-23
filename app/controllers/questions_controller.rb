class QuestionsController < ApplicationController
  helper URLHelper
  before_action :check_authorization
  before_action :set_question, only: [:edit, :show, :update, :destroy]

  respond_to :html

  def index
    @questions = Question.all.decorate
    respond_with(@questions)
  end

  def show
    respond_with(@question)
  end

  def new
    @question = Question.new
    prompt = Prompt.for(params[:prompt_type]).new
    if prompt.is_a? Prompt::PassagePrompt
      passage = Passage.new
      prompt.update_attributes(passage: passage)
    end
    @question.update_attributes(prompt: prompt)
    4.times { @question.choices.build }
    respond_with(@question.decorate)
  end

  def edit
  end

  def create
    @question = Question.new(question_params).decorate
    @question.save
    respond_with(@question)
  end

  def update
    @question.update(question_params)
    respond_with(@question)
  end

  def destroy
    @question.destroy
    respond_with(@question)
  end

  private

  def check_authorization
    unless current_user.admin?
      redirect_back_or_to path: tests_path, error: "You cannot access that page"
    end
  end

  def set_question
    @question = Question.find(params[:id]).decorate
  end

  def question_params
    params.require(:question).permit(:prompt, :difficulty, :grade_level, :subject_list, :tag_list, prompt_attributes: prompt_params, choices_attributes: [:id,:answer, :content])
  end

  def prompt_params
    @question.prompt.class.params
  end
end
