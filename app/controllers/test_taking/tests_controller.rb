class TestTaking::TestsController < ApplicationController
  layout "test_taking"
  before_action :set_test, only: [:show, :edit, :update, :destroy, :report, :complete, :start]

  def show
    if @test.finished?
      redirect_to test_report_path(@test)
    else
      redirect_to tests_path
    end
  end

  def start
    @test.start!
    redirect_to test_taking_test_question_path(@test, @test.position)
  end

  def complete
    if @test.complete!
      redirect_to test_report_path(@test)
    else
      redirect_back_or_to path: test_path(@test), error: "The test could not be completed"
    end
  end

  def reset
    @test.responses.destroy_all
  end

  private

  def set_test
    @test = current_user.tests.find(params[:id]).decorate
  end

  def test_params
    params.require(:test)
  end

end
