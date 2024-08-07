require 'rails_helper'

RSpec.describe UserRegistrationService, type: :service do
  describe '#call' do
    context 'quando os parâmetros são válidos' do
      let(:valid_params) { attributes_for(:user) }
      let(:service) { UserRegistrationService.new(valid_params) }
      let(:result) { service.call }

      it 'registra um usuário com sucesso' do
        expect(result[:success]).to be true
        expect(result[:user]).to be_instance_of(User)
        expect(result[:user].name).to eq(valid_params[:name])
        expect(result[:user].email).to eq(valid_params[:email])
      end
    end

    context 'quando os parâmetros são inválidos' do
      let(:invalid_params) do
        {
          name: '',  # Nome inválido
          email: 'john.doe@example.com',
          password: 'password',
          password_confirmation: 'different_password'  # Senha não confere
        }
      end

      let(:service) { UserRegistrationService.new(invalid_params) }
      let(:result) { service.call }

      it 'não registra o usuário e retorna erros' do
        expect(result[:success]).to be false
        expect(result[:errors]).to include("Name não pode ficar em branco")
        expect(result[:errors]).to include("Password confirmation não confere com a senha")
      end
    end
  end
end
