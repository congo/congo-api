# == Schema Information
#
# Table name: invoices
#
#  id              :integer          not null, primary key
#  account_id      :integer
#  membership_id   :integer
#  cents           :integer
#  plan_name       :string
#  payment_id      :integer
#  paid            :boolean
#  properties_data :text
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#
# Indexes
#
#  index_invoices_on_deleted_at  (deleted_at)
#

class Invoice < ActiveRecord::Base
  include Propertied

  acts_as_paranoid

  belongs_to :account
  belongs_to :membership
  belongs_to :payment

  PLAN_COSTS = {
    basic: 100,
    standard: 100,
    premier: 100,
    admin: 0
  }
end
