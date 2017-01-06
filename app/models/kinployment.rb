class Kinployment < ApplicationRecord
  belongs_to :kinployee, optional: true
  belongs_to :kinployer

  serialize :cultural_backgrounds,  Array
  serialize :location,              Hash
  serialize :preferred_languages,   Array
  serialize :preferred_skills,      Array

  ##
  # Assign a Kinployee to this Kinployment.

  def match( kinployee )
    self.kinployee = kinployee
  end

  ##
  # Indicate whether this Kinployment has been matched with a Kinployee.

  def matched?
    !!kinployee
  end

  ##
  # Unassign the associated Kinployee, if it exists.

  def unmatch
    self.kinployee = nil
  end
end