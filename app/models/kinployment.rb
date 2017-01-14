class Kinployment < ApplicationRecord
  belongs_to :kinployee, optional: true
  belongs_to :kinployer

  serialize :cultural_backgrounds,  Array
  serialize :location,              Hash
  serialize :preferred_languages,   Array
  serialize :preferred_skills,      Array

  ##
  # Assign a Kinployee to this Kinployment.

  def engage( kinployee )
    self.kinployee = kinployee
  end

  ##
  # Indicate whether this Kinployment is engaged with a Kinployee.

  def engaged?
    !!kinployee
  end

  ##
  # Unassign the associated Kinployee, if it exists.

  def disengage
    self.kinployee = nil
  end
end