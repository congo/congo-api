# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  reference_number :string
#  account_id       :integer
#  properties_data  :text
#  created_at       :datetime
#  updated_at       :datetime
#  deleted_at       :datetime
#

class Enrollment < ActiveRecord::Base
  #include Propertied

  acts_as_paranoid
  before_save :populate_reference_number

  def populate_reference_number
    self.reference_number ||= "999999999" #ThirtySix.generate
  end


end
