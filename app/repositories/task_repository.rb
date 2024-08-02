class TaskRepository
    def self.all_for_user(user_id)
      Task.where(user_id: user_id)
    end
  
    def self.find_by_id_and_user(id, user_id)
      Task.find_by(id: id, user_id: user_id)
    end
  
    def self.create(params, user_id)
      Task.create(params.merge(user_id: user_id))
    end
  
    def self.update(task, params)
      task.update(params)
    end
  
    def self.destroy(task)
      task.destroy
    end
  end