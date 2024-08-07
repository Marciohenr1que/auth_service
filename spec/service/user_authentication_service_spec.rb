require 'rails_helper'

RSpec.describe UserAuthenticationService, type: :service do
  describe '#call' do
    let!(:user) { create(:user) }
    let(:valid_email) { user.email }
    let(:valid_password) { 'password' }
    let(:invalid_email) { 'xxmarciod@mail.com' }
    let(:invalid_password) { '123456' }

    context 'quando as credenciais são válidas' do
      it 'autentica o usuário e retorna um token' do
        service = UserAuthenticationService.new(valid_email, valid_password)
        result = service.call

        expect(result[:success]).to be true
        expect(result[:user]).to eq(user)
        expect(result[:token]).to be_present
        decoded_token = Auth::TokenExtractHelper.decode(result[:token])
        expect(decoded_token[:user_id]).to eq(user.id)
      end
    end

    context 'quando as credenciais são inválidas' do
      it 'não autentica o usuário e retorna um erro' do
        service = UserAuthenticationService.new(invalid_email, invalid_password)
        result = service.call

        expect(result[:success]).to be false
        expect(result[:errors]).to include("Invalid email or password")
      end
    end
  end
end
