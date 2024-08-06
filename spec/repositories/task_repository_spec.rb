require 'rails_helper'

RSpec.describe TaskRepository, type: :repository do
  let(:user) { create(:user) } 
  let!(:task) { create(:task, user: user) } 

  describe '.all_for_user' do
    it 'retorna todas as tarefas para um usuário' do
      tasks = TaskRepository.all_for_user(user.id)
      expect(tasks).to include(task)
    end
  end

  describe '.find_by_id_and_user' do
    it 'encontra uma tarefa pelo id e user_id' do
      found_task = TaskRepository.find_by_id_and_user(task.id, user.id)
      expect(found_task).to eq(task)
    end

    it 'retorna nil se a tarefa não pertencer ao usuário' do
      another_user = create(:user)
      found_task = TaskRepository.find_by_id_and_user(task.id, another_user.id)
      expect(found_task).to be_nil
    end
  end

  describe '.create' do
    it 'cria uma nova tarefa' do
      params = { title: 'New Task', description: 'New Description' }
      new_task = TaskRepository.create(params, user.id)
      expect(new_task).to be_persisted
      expect(new_task.title).to eq('New Task')
      expect(new_task.description).to eq('New Description')
      expect(new_task.user_id).to eq(user.id)
    end
  end

  describe '.update' do
    it 'atualiza uma tarefa existente' do
      updated_params = { title: 'Updated Title' }
      TaskRepository.update(task, updated_params)
      task.reload
      expect(task.title).to eq('Updated Title')
    end
  end

  describe '.destroy' do
    it 'deleta uma tarefa existente' do
      expect { TaskRepository.destroy(task) }.to change { Task.count }.by(-1)
    end
  end
end
