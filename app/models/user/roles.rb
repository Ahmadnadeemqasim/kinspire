class User
  ROLES = [ 'admin', 'kinployee', 'kinployer' ]

  has_one :kinployee, dependent: :destroy
  has_one :kinployer, dependent: :destroy

  validates_associated :kinployee
  validates_associated :kinployer

  validate :role_associations

  private def role_associations
    if    is_admin?;      admin_associations
    elsif is_kinployee?;  kinployee_associations
    elsif is_kinployer?;  kinployer_associations
    else
      errors[:role] << "User role is not defined."
    end
  end

  private def admin_associations
    errors[:kinployee] << "Admin user may not own a Kinployee." if self.kinployee
    errors[:kinployer] << "Admin user may not own a Kinployer." if self.kinployer
  end

  private def kinployee_associations
    errors[:kinployee] << "Kinployee user must own a Kinployee." unless self.kinployee
    errors[:kinployer] << "Kinployee user may not own a Kinployer." if self.kinployer
  end

  private def kinployer_associations
    errors[:kinployer] << "Kinployer user must own a Kinployer." unless self.kinployer
    errors[:kinployee] << "Kinployer user may not own a Kinployee." if self.kinployee
  end

  ##
  # Indicate whether this user is an admin.

  def is_admin?
    self.role == 'admin'
  end

  ##
  # Indicate whether this user is a Kinployee.

  def is_kinployee?
    self.role == 'kinployee'
  end

  ##
  # Indicate whether this user is a Kinploy   er.

   def is_kinployer?
     self.role == 'kinployer'
  end

  module Roles
  end
end