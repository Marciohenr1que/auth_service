require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:valid_user_attributes) { attributes_for(:user) }

  let(:valid_attributes) do
    {
      user: valid_user_attributes
    }
  end

  let(:invalid_attributes) do
    {
      user: valid_user_attributes.merge(password_confirmation: 'mismatch')  # Senha de confirmação errada
    }
  end

  describe 'POST #create' do
    context 'com parâmetros válidos' do
      it 'cria um novo usuário e retorna um status 201' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['email']).to eq(valid_user_attributes[:email])
      end
    end

    context 'com parâmetros inválidos' do
      it 'não cria um usuário e retorna um status 422' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
