module Validations
    module TaskValidations
      extend ActiveSupport::Concern
  
      included do
        validates :title, presence: { message: 'não pode ficar em branco' }
        validates :description, presence: { message: 'não pode ficar em branco' }
      end
    end
  end