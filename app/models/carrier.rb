# == Schema Information
#
# Table name: carriers
#
#  id              :integer          not null, primary key
#  name            :string
#  slug            :string
#  account_id      :integer
#  properties_data :text
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#
# Indexes
#
#  index_carriers_on_deleted_at  (deleted_at)
#

class Carrier < ActiveRecord::Base
  include Sluggable
  include Propertied

  acts_as_paranoid

  belongs_to :account

  has_many :benefit_plans
  has_many :carrier_accounts
end

