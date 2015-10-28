# == Schema Information
#
# Table name: invitations
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  uuid        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  deleted_at  :datetime
#
# Indexes
#
#  index_invitations_on_deleted_at  (deleted_at)
#

class Invitation < ActiveRecord::Base
  acts_as_paranoid

  has_one :role

  belongs_to :account

  before_save :add_uuid

  def add_uuid
    self.uuid = ThirtySix.generate
  end
end

