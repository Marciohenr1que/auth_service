require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validações' do
    let(:user) { create(:user) } 
    
    it 'é válido com título e descrição presentes' do
      task = build(:task, user: user) 
      expect(task).to be_valid
    end

    it 'não é válido sem um título' do
      task = build(:task, title: nil, user: user) 
      expect(task).to_not be_valid
      expect(task.errors[:title]).to include('não pode ficar em branco')
    end

    it 'não é válido sem uma descrição' do
      task = build(:task, description: nil, user: user) 
      expect(task).to_not be_valid
      expect(task.errors[:description]).to include('não pode ficar em branco')
    end
  end
end
