module Validations
  module UserValidations
    extend ActiveSupport::Concern

    included do
      validates :name, presence: { message: 'não pode ficar em branco' }
      validates :email, presence: { message: 'não pode ficar em branco' },
                        uniqueness: { message: 'já está em uso' }
      validates :password, presence: { message: 'não pode ficar em branco' },
                           length: { minimum: 5, message: 'deve ter pelo menos 5 caracteres' }
      validates :password_confirmation, presence: { message: 'não pode ficar em branco' }
      validate :passwords_match
    end

    private

    def passwords_match
      if password != password_confirmation
        errors.add(:password_confirmation, 'não confere com a senha')
      end
    end
  end
end