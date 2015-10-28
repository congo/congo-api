# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  reference_number :string
#  account_id       :integer
#  properties_data  :json
#  created_at       :datetime
#  updated_at       :datetime
#  deleted_at       :datetime
#
# Indexes
#
#  index_enrollments_on_deleted_at        (deleted_at)
#  index_enrollments_on_reference_number  (reference_number)
#

class Enrollment < ActiveRecord::Base

  acts_as_paranoid
  before_save :populate_reference_number

  def populate_reference_number
    self.reference_number ||= ThirtySix.generate
  end


end
