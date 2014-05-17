class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  validates_numericality_of :quantity, only_integer: true
end
