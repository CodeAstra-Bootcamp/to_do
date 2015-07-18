class TasksController < ApplicationController
  # TODO:
  #   1. Ajax
  #   2. Show time of accomplishment for accomplished tasks
  #   3. Make Ajax requests responsive
  #   4. Ability to reorder tasks
  #   5. Tasks should belong to user
  #   6. Share tasks and people with whom you share can see the task
  # 
  def index
    @tasks = Task.all.order(position: :asc)
    @new_task = Task.new
  end

  def create
    @task = Task.new(task_params)
    last_task = Task.order(position: :desc).limit(1).first
    if last_task
      @task.position = last_task.position + 1
    else
      @task.position = 1
    end
    @task.save!
  end

  def update
    @task = Task.find(params[:id])
    if params[:done] == true.to_s
      @task.done_at = nil
    else
      @task.done_at = Time.now
    end
    @task.save!
  end

  def sort
    ids_params = params[:ids].collect(&:to_i)
    tasks = Task.where(id: ids_params)
    tasks.each do |task|
      task.update_attribute(:position, (ids_params.index(task.id) + 1))
    end

    render nothing: true
  end

  def destroy
    @task = Task.where(id: params[:id]).first
    @task.destroy if @task
  end

private
  def task_params
    params.require(:task).permit(:title)
  end
end
