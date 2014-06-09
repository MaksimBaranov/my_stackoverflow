class Tag < ActiveRecord::Base
  default_scope { order('name ASC') }

  has_many :taggings
  has_many :questions, through: :taggings
end
