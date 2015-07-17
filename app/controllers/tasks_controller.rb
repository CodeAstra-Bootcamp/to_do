class TasksController < ApplicationController
  # TODO:
  #   1. Ajax
  #   2. Show time of accomplishment for accomplished tasks
  #   3. Ability to reorder tasks
  #   4. Tasks should belong to user
  #   5. Share tasks and people with whom you share can see the task
  # 

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

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path
  end

private
  def task_params
    params.require(:task).permit(:title)
  end
end
