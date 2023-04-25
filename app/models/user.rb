class User < ApplicationRecord
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :password, presence: true
  validates :password_confirmation, presence: true


  has_secure_password
  has_secure_token :api_key

  before_create :create_key

  private

  def create_key
    self.api_key = SecureRandom.hex(13)
  end
end