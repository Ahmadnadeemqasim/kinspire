class Kinployee < ApplicationRecord
  belongs_to :user
  has_many :kinployments, dependent: :nullify
  has_many :kinployers, through: :kinployments

  validates :user, uniqueness: true

  serialize :cultural_backgrounds,  Array
  serialize :languages,             Array
  serialize :location,              Hash
  serialize :skills,                Array
end