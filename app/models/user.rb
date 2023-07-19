class User < ApplicationRecord

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  has_secure_password

  before_save { self.email = email.strip.downcase }

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.strip.downcase)
    @user && @user.authenticate(password) ? @user : nil
  end

end
