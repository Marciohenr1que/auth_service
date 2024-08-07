require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) } 
  let(:task) { create(:task, user: user) } 

  before do
    # Autentica o user
    token = Auth::TokenExtractHelper.encode(user_id: user.id)
    request.headers['Authorization'] = "Bearer #{token}"
  end

  
  describe 'GET #show' do
    context 'quando a tarefa existe' do
      it 'retorna a tarefa' do
        get :show, params: { id: task.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['title']).to eq(task.title)
      end
    end

    context 'quando a tarefa não existe' do
      it 'retorna um erro 404' do
        get :show, params: { id: 99999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Not Found')
      end
    end
  end

  describe 'POST #create' do
    context 'com parâmetros válidos' do
      let(:valid_params) { { task: { title: 'New Task', description: 'New Description' } } }

      it 'cria uma nova tarefa' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['title']).to eq('New Task')
      end
    end
    

    context 'com parâmetros inválidos' do
      let(:invalid_params) { { task: { title: '', description: '' } } }

      it 'retorna um erro 422' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['title']).to include("não pode ficar em branco")
        expect(JSON.parse(response.body)['description']).to include("não pode ficar em branco")
      end
    end
  end

  describe 'PUT #update' do
    context 'com parâmetros válidos' do
      let(:valid_params) { { id: task.id, task: { title: 'Updated Title' } } }

      it 'atualiza a tarefa existente' do
        put :update, params: valid_params
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['title']).to eq('Updated Title')
      end
    end

    context 'com parâmetros inválidos' do
      let(:invalid_params) { { id: task.id, task: { title: '' } } }

      it 'retorna um erro 404 se a tarefa não for encontrada' do
        put :update, params: { id: 99999, task: { title: '' } }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Not Found')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deleta a tarefa existente' do
      delete :destroy, params: { id: task.id }
      expect(response).to have_http_status(:no_content)
      expect(Task.exists?(task.id)).to be_falsey
    end

    it 'retorna um erro 404 se a tarefa não for encontrada' do
      delete :destroy, params: { id: 99999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Not Found')
    end
  end
end
