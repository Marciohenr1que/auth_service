require 'rails_helper'

RSpec.describe UserRepository, type: :repository do
  describe '.find_by_email' do
    let!(:usuario) { create(:user, email: 'xxmarcio@gmail.com') }

    it 'encontra um usuário pelo email' do
      resultado = UserRepository.find_by_email('xxmarcio@gmail.com')
      expect(resultado).to eq(usuario)
    end

    it 'retorna nil se o email não existir' do
      resultado = UserRepository.find_by_email('naoexiste@gmail.com')
      expect(resultado).to be_nil
    end
  end

  describe '.find_by_id' do
    let!(:usuario) { create(:user) }

    it 'encontra um usuário pelo id' do
      resultado = UserRepository.find_by_id(usuario.id)
      expect(resultado).to eq(usuario)
    end

    it 'gera um erro se o id não existir' do
      expect { UserRepository.find_by_id(999) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
