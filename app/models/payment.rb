# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  account_id :integer
#  cents      :integer
#  properties :text
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#
# Indexes
#
#  index_payments_on_deleted_at  (deleted_at)
#

class Payment < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :account

  has_many :invoices
end

