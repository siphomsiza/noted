class User < ActiveRecord::Base
  #ActiveRecord::Base.establish_connection($current_session_db)
  ActiveRecord::Base.establish_connection(Rails.env.to_sym)
  belongs_to :department
  has_many :role, :dependent => :destroy
  has_many :kpi_results
  has_many :top_layer_administrators
  has_many :assurances
  has_many :kpi_owners
  has_one :subdepartmental_administrator
  has_one :departmental_administrator
  has_many :activity_logs
  delegate :firstname,:surname, :to => :subdepartmental_administrator, :prefix => true
  delegate :firstname,:surname, :to => :top_layer_administrators, :prefix => true
  delegate :firstname,:surname,:email, :to => :roles, :prefix => true
  delegate :firstname,:surname,:email, :to => :kpi_results, :prefix => true
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :firstname,presence: true, length: { maximum: 50 }
  has_attached_file :avatar, :styles => { :medium => "300x300>",:small=> "140x140", :thumb => "60x60" }, :default_url => "/avatars/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  #validates_presence_of  :title, :surname, :id_number, :gender, :race, :manager, :location, :mobile, :landline, :fax, :country_prefix, :occupational_category, :birthday
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

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
  # Send primary user notification email.
  def send_primary_reminder_email
    UserMailer.primary_reminder_email(self).deliver_now
  end
  # Send secondary user notification email.
  def send_secondary_reminder_email
    UserMailer.secondary_reminder_email(self).deliver_now
  end
  def editable_by?(user)
    self.user_editors(user)#.include?(user)
  end
  def user_editors(user)
    user == user || user.admin? || user.super_admin?
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_unlocked_account_email
    UserMailer.account_unlocked(self).deliver_now
  end

  def send_locked_account_email
    UserMailer.account_locked(self).deliver_now
  end
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end


end
