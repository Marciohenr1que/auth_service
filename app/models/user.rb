class User < ApplicationRecord
  has_secure_password
  include Validations::UserValidations
  
end