class TasksController < ApplicationController
  def index
    @new_task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save!
    redirect_to root_path
  end

  def update
    @task = Task.find(params[:id])
    if @task.done?
      @task.done_at = nil
    else
      @task.done_at = Time.now
    end
    @task.save!
    redirect_to root_path
  end

private
  def task_params
    params.require(:task).permit(:title)
  end
end
