class TasksController < ApplicationController
  before_action :set_footprint, only: %i[new create]

  def new
    @footprint = Footprint.find(params[:footprint_id])
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.footprint = @footprint
    if @task.save
      redirect_to footprint_path(@footprint)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_footprint
    @footprint = Footprint.find(params[:footprint_id])
  end

  def task_params
    params.require(:task).permit(:name, :ghg_contribution, :start_date, :end_date, :owner_id)
  end
end
