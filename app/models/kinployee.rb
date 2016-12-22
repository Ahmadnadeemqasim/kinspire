class Kinployee < ApplicationRecord
  belongs_to :user
  has_many :kinployments, dependent: :nullify
  has_many :kinployers, through: :kinployments

  validates :user, uniqueness: true

  serialize :cultural_backgrounds, Array
end