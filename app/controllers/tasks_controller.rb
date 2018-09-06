class TasksController < ApplicationController
  before_action :require_user_logged_in

  def index
    @user = current_user
    @task = @user.tasks.build
    @tasks = @user.tasks.order('created_at DESC').page(params[:page])
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @user = current_user
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
  
    if @task.save
      flash[:success] = 'Task が登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が登録されませんでした'
      render :new
    end
  end

  def edit; end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash.now[:success] = 'Task が更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は削除されました'
    redirect_to tasks_url
  end

  private
    def task_params
      params.require(:task).permit(:user_id, :content, :status)
    end
end
