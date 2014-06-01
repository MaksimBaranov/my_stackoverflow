class Tagging < ActiveRecord::Base
  belongs_to :questions
  belongs_to :tags
end
