class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :favoriteable, polymorphic: true
end
