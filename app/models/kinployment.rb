class Kinployment < ApplicationRecord
  belongs_to :kinployee, optional: true
  belongs_to :kinployer

  serialize :cultural_backgrounds,  Array
  serialize :preferred_languages,   Array
  serialize :preferred_skills,      Array
end