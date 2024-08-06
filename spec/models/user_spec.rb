require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validações' do
    it 'é válido com atributos válidos' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'não é válido sem um nome' do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include('não pode ficar em branco')
    end

    it 'não é válido sem um e-mail' do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('não pode ficar em branco')
    end

    it 'não é válido com um e-mail duplicado' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('já está em uso')
    end

    it 'não é válido se as senhas não conferem' do
      user = build(:user, password_confirmation: 'different')
      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation]).to include('não confere com a senha')
    end

  end
end

