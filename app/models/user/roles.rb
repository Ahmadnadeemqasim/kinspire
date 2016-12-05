class User
  enum role: [ :admin, :kinployee, :kinployer ]

  has_one :kinployee, dependent: :destroy
  has_one :kinployer, dependent: :destroy

  validates_associated :kinployee
  validates_associated :kinployer

  validate :admin_associations,     if: "admin?"
  validate :kinployee_associations, if: "kinployee?"
  validate :kinployer_associations, if: "kinployer?"

  private def admin_associations
    errors[:base] << "Admin user may not own a Kinployer." if self.kinployer
    errors[:base] << "Admin user may not own a Kinployee." if self.kinployee
  end

  private def kinployee_associations
    errors[:base] << "Kinployee user must own a Kinployee." unless self.kinployee
    errors[:base] << "Kinployee user may not own a Kinployer." if self.kinployer
  end

  private def kinployer_associations
    errors[:base] << "Kinployer user must own a Kinployer." unless self.kinployer
    errors[:base] << "Kinployer user may not own a Kinployee." if self.kinployee
  end

  module Roles
  end
end