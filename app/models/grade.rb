class Grade < ApplicationRecord
  has_many :problems
  enum band: [ :easy, :moderate, :intermediate, :advanced, :expert ]
  enum grade_type: [ :font, :trad ]
end
