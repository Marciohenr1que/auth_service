require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) { create(:user) } # Usa o FactoryBot para criar um usuário
  let(:valid_params) { { auth: { email: user.email, password: 'password' } } }
  let(:invalid_params) { { auth: { email: 'wrong_email@example.com', password: 'wrong_password' } } }

  describe 'POST #login' do
    context 'credenciais são válidas' do
      it 'retorna um token e os dados do usuário' do
        post :login, params: valid_params
        expect(response).to have_http_status(:ok)
        
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to have_key('token')
        expect(parsed_response).to have_key('user')
        expect(parsed_response['user']).to include(
          'name' => user.name,
          'email' => user.email
        )
      end
    end

    context 'quando as credenciais são inválidas' do
      it 'retorna um erro de autenticação' do
        post :login, params: invalid_params
        expect(response).to have_http_status(:unauthorized)
        
        parsed_response = JSON.parse(response.body)
        expect(parsed_response).to have_key('errors')
        expect(parsed_response['errors']).to include('Invalid email or password')
      end
    end
  end
end