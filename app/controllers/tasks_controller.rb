class TasksController < ApplicationController
  # TODO:
  #   1. Ajax
  #   2. Show time of accomplishment for accomplished tasks
  #   3. Ability to reorder tasks
  #   4. Make Ajax requests responsive
  #   5. Tasks should belong to user
  #   6. Share tasks and people with whom you share can see the task
  # 

  before_action :authenticate_user!

  def index
    @tasks = current_user.tasks.order(position: :asc)
    @new_task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    last_task = current_user.tasks.order(position: :desc).limit(1).first
    if last_task
      @task.position = last_task.position + 1
    else
      @task.position = 1
    end
    @save_success = true if @task.save
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if params[:done] == true.to_s
      @task.done_at = nil
    else
      @task.done_at = Time.now
    end
    @task.save!
  end

  def sort
    ids_params = params[:ids].collect(&:to_i)
    tasks = current_user.tasks.where(id: ids_params)
    tasks.each do |task|
      task.update_attribute(:position, (ids_params.index(task.id) + 1))
    end

    render nothing: true
  end

  def destroy
    @task = current_user.tasks.where(id: params[:id]).first
    @task.destroy if @task
  end

private
  def task_params
    params.require(:task).permit(:title)
  end
end
