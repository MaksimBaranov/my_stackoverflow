class User < ActiveRecord::Base
  default_scope { order('name ASC') }

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :preferences
  has_many :votes
  has_many :favorites
  has_many :authorizations

  attr_accessor :new_email

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]

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

    if auth.info.has_key?(:email)
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
    else
      fake_email = 'fake_email@user.com'
      checksum =  Array.new(20){[*'A'..'Z', *0..9, *'a'..'z'].sample}.join

      password = Devise.friendly_token[0, 20]
      user = User.create!(email: fake_email, password: password, password_confirmation: password)
      user.authorizations.create(provider: auth.provider, uid: auth.uid.to_s, checksum: checksum )

      user
    end
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  def change_email(new_email)
    self.update!(email: new_email)
  end
end

