class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  
  #skip downcase_email call back because not needed for in store orders
  #Customer may choose to update their email later and can be done via website portal
  before_save :downcase_email
  before_create :create_activation_digest

  VAILID_PHONENUMBER_REGEX = /\A\d{10}\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name,   presence: true, length: {maximum: 50} 
  validates :last_name,    presence: true, length: {maximum: 50}
  validates :phone_number, presence: true, length: {maximum: 10},
                           format: {with: VAILID_PHONENUMBER_REGEX} 
  validates :email,        presence: true, length: {maximum: 255}, 
                           format: {with: VALID_EMAIL_REGEX}, 
                           uniqueness: {case_sensitive: false}
  validates :terms, presence: true
  validates :terms, presence: true
  has_secure_password
  validates :password,     presence: true, length: {minimum: 1}, allow_nil: true
  


# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

 
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
  #makes all emails for User lowercase 
  def downcase_email
    self.email = email.downcase unless self.email.nil? 
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


end
