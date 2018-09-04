class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @user = current_user
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    else
      redirect_to signup_path
    end
  end

  def show
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

  def edit
  end

  def update
    if @task.update(task_params)
      flash.now[:success] = 'Task が更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'Task は削除されました'
    # リダイレクトのときだけ _url を使う
    redirect_to tasks_url
  end

  private
    # taskの検索を共通化する
    def set_task
      @task = Task.find(params[:id])
    end

    # ストロングパラメータ
    def task_params
      params.require(:task).permit(:user_id, :content, :status)
    end
end
