class TasksController < ApplicationController
  before_action :require_user_loggen_in
  before_action :correct_user, only: [:destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(3)
      @user = @task.user
      counts(@user)
    end
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に作成されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(3)
      flash.now[:danger] = 'Taskが作成されませんでした'
      
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    #@task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
