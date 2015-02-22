class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy, :report, :complete]

  respond_to :html

  def index
    if current_user.admin?
      @tests = Test.all
    else
      @tests = current_user.tests
    end
    respond_with(@tests)
  end

  def show
    respond_with(@test)
  end

  def new
    @test = Test.new.decorate
    @test.build_test_configuration
    respond_with(@test)
  end

  def edit
  end

  def create
    @test = Test.new(test_params).decorate
    respond_to do |format|
      if @test.save
        format.html { redirect_to test_path(@test), success: 'Test list was successfully created.' }
        format.json { render action: 'show', status: :created, location: @test }
      else
        format.html { render action: 'new', error: "Test could not be created."}
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to test_path(@test), success: 'Test list was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', error: "Test could not be updated." }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_path }
      format.json { head :no_content }
    end
  end

  def report
    if current_user.can_view_report?(@test)
      respond_with(@test)
    else
      redirect_back_or_to path: tests_path, error: "You cannot view this report"
    end
  end

  def complete
    if @test.complete!
      redirect_to test_report_path(@test)
    else
      redirect_back_or_to path: test_path(@test), error: "The test could not be completed"
    end
  end


  private
    def set_test
      @test = Test.find(params[:id]).decorate
    end

    def test_params
      params.require(:test).permit(:user_id, test_configuration_attributes: test_configuration_params)
    end

    def test_configuration_params
      [:min_difficulty, :max_difficulty, :min_grade_level, :max_grade_level, :subject_list, :tag_list, :number_of_questions]
    end
end
