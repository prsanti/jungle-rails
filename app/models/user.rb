class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  # before_save do
  #   self.email.downcase.strip if self.email
  #   # p self.email
  # end

  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end


  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.strip)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
