class Kinployer < ApplicationRecord
  belongs_to :user
  has_many :kinployments, dependent: :nullify
  has_many :kinployees, through: :kinployments

  validates :user, uniqueness: true
end