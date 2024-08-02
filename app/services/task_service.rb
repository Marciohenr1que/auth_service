class TaskService
    def initialize(user)
      @user = user
    end
  
    def list_tasks
      TaskRepository.all_for_user(@user.id)
    end
  
    def show_task(id)
      TaskRepository.find_by_id_and_user(id, @user.id)
    end
  
    def create_task(params)
      TaskRepository.create(params, @user.id)
    end
  
    def update_task(id, params)
      task = TaskRepository.find_by_id_and_user(id, @user.id)
      return nil unless task
  
      TaskRepository.update(task, params)
      task
    end
  
    def destroy_task(id)
      task = TaskRepository.find_by_id_and_user(id, @user.id)
      return nil unless task
  
      TaskRepository.destroy(task)
      task
    end
  end