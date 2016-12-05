class Kinployment < ApplicationRecord
  belongs_to :kinployee, optional: true
  belongs_to :kinployer
end