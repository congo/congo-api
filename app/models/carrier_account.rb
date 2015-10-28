# == Schema Information
#
# Table name: carrier_accounts
#
#  id              :integer          not null, primary key
#  account_id      :integer
#  carrier_id      :integer
#  name            :string
#  properties_data :text
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#
# Indexes
#
#  index_carrier_accounts_on_deleted_at  (deleted_at)
#

class CarrierAccount < ActiveRecord::Base
  include Propertied

  acts_as_paranoid

  belongs_to :account
  belongs_to :carrier

  has_many :benefit_plans
end

