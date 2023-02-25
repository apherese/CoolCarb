class TasksController < ApplicationController
  before_action :set_footprint, :set_company, only: %i[new create]

  def new
    @footprint = Footprint.find(params[:footprint_id])
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.footprint = @footprint
    suggested_tasks_impact
    if @task.save
      redirect_to targets_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_footprint
    @footprint = Footprint.find(params[:footprint_id])
  end

  def set_company
    @company = @footprint.company
  end

  def task_params
    params.require(:task).permit(:name, :ghg_contribution, :start_date, :end_date, :owner_id)
  end

  def suggested_tasks_impact
    if params[:task][:name] == "Remplacer la cuve fioul par une pompe à chaleur"
      @ghg_result_initial = @footprint.ghg_result
      @footprint.fioul = 0
      @simul_footprint_post_action = ::FootprintCalculation.new(@company, @footprint).calculate
      @task.ghg_contribution = @ghg_result_initial - @simul_footprint_post_action.ghg_result
    elsif params[:task][:name] == "Electricité intelligente du bâtiment"
      @ghg_result_initial = @footprint.ghg_result
      @footprint.electricite = 0.85 * @footprint.electricite
      @simul_footprint_post_action = ::FootprintCalculation.new(@company, @footprint).calculate
      @task.ghg_contribution = @ghg_result_initial - @simul_footprint_post_action.ghg_result
    elsif params[:task][:name] == "Proposer une réduction aux clients venant en train"
      @ghg_result_initial = @footprint.ghg_result
      @footprint.clients_int = 0.3 * @footprint.clients_int
      @simul_footprint_post_action = ::FootprintCalculation.new(@company, @footprint).calculate
      @task.ghg_contribution = @ghg_result_initial - @simul_footprint_post_action.ghg_result
    end
  end
end
