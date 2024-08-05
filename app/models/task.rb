class Task < ApplicationRecord
  belongs_to :user
  include Validations::TaskValidations
end