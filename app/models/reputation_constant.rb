class ReputationConstant < ActiveRecord::Base
  ONEPOINT  = find_by(code: "one_point").value
  TWOPOINTS   = find_by(code: "two_points").value
  THREEPOINTS     = find_by(code: "three_points").value
end
