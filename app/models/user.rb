class User < ActiveRecord::Base
  default_scope { order('name ASC') }

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :preferences
  has_many :votes
  has_many :authorizations

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

   CONVERTING = {
      hour: 3600,
      day: 24
   }

  def joined_days_ago
    diff = Time.now - self.created_at
    ( diff / (CONVERTING[:hour]*CONVERTING[:day]) ).to_i
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.create_authorization(auth)
    end

    user
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end

