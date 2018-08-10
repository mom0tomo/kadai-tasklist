class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
  
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
      params.require(:task).permit(:content, :status)
    end
end
