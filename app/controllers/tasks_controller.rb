class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    service = TaskService.new(current_user)
    @tasks = service.list_tasks
    render json: @tasks
  end

  def show
    if @task
      render json: @task
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end

  def create
    service = TaskService.new(current_user)
    @task = service.create_task(task_params)

    if @task.persisted?
      send_notification('created', @task)
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    @task = TaskService.new(current_user).update_task(params[:id], task_params)

    if @task
      send_notification('updated', @task)
      render json: @task
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end

  def destroy
    if @task && TaskService.new(current_user).destroy_task(params[:id])
      send_notification('deleted', @task)
      head :no_content
    else
      render json: { error: 'Not Found' }, status: :not_found
    end
  end

  private

  def authenticate_user!
    token = request.headers['Authorization'].to_s.split(' ').last
    decoded_token = JsonWebToken.decode(token)

    if decoded_token
      @current_user = User.find(decoded_token[:user_id])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def set_task
    @task = TaskService.new(current_user).show_task(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def send_notification(action, task)
    begin
      notification_client = NotificationClient.new
      notification_client.send_notification(
        action: action,
        user_id: current_user.id,
        user_email: current_user.email,
        task_id: task.id,
        task_title: task.title,
        task_description: task.description
      )
    rescue StandardError => e
      Rails.logger.error("Failed to send notification: #{e.message}")
    end
  end
end
