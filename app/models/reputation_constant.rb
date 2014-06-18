class ReputationConstant < ActiveRecord::Base
  ONEPOINT  = find_by(code: "one_point")
  TWOPOINTS   = find_by(code: "two_points")
  THREEPOINTS     = find_by(code: "three_points")
end
