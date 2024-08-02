class TasksController < ApplicationController
    before_action :authenticate_user
    before_action :set_task, only: [:show, :update, :destroy]
  
    # GET /tasks
    def index
      service = TaskService.new(current_user)
      @tasks = service.list_tasks
  
      render json: @tasks
    end
  
    # GET /tasks/:id
    def show
      render json: @task
    end
  
    # POST /tasks
    def create
      service = TaskService.new(current_user)
      @task = service.create_task(task_params)
  
      if @task.persisted?
        render json: @task, status: :created
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  
   
    def update
      @task = TaskService.new(current_user).update_task(params[:id], task_params)
  
      if @task
        render json: @task
      else
        render json: { error: 'Not Found' }, status: :not_found
      end
    end
  
  
    def destroy
      if TaskService.new(current_user).destroy_task(params[:id])
        head :no_content
      else
        render json: { error: 'Not Found' }, status: :not_found
      end
    end
  
    private
  
    def set_task
      @task = TaskService.new(current_user).show_task(params[:id])
      render json: { error: 'Not Found' }, status: :not_found unless @task
    end
  
    def task_params
      params.require(:task).permit(:title, :description)
    end
  end
  