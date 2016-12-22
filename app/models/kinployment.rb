class Kinployment < ApplicationRecord
  belongs_to :kinployee, optional: true
  belongs_to :kinployer

  serialize :cultural_backgrounds, Array
end