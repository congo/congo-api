# == Schema Information
#
# Table name: application_statuses
#
#  id             :integer          not null, primary key
#  account_id     :integer
#  application_id :integer
#  payload        :text
#  created_at     :datetime
#  updated_at     :datetime
#  deleted_at     :datetime
#
# Indexes
#
#  index_application_statuses_on_deleted_at  (deleted_at)
#

class ApplicationStatus < ActiveRecord::Base
  belongs_to :application
  belongs_to :account_id

  acts_as_paranoid
end

