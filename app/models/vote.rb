class Vote < ActiveRecord::Base
  has_one :question
  has_one :answer
  validates_numericality_of :quantity, only_integer: true
end
