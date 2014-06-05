class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :comments
  has_many :preferences
  has_many :votes, through: :preferences

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   CONVERTING = {
      hour: 3600,
      day: 24
   }

  def joined_days_ago
    diff = Time.now - self.created_at
    ( diff / (CONVERTING[:hour]*CONVERTING[:day]) ).to_i
  end
end
