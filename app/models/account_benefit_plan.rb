# == Schema Information
#
# Table name: account_benefit_plans
#
#  id                 :integer          not null, primary key
#  account_id         :integer
#  carrier_id         :integer
#  carrier_account_id :integer
#  benefit_plan_id    :integer
#  properties_data    :text
#  created_at         :datetime
#  updated_at         :datetime
#  deleted_at         :datetime
#
# Indexes
#
#  index_account_benefit_plans_on_deleted_at  (deleted_at)
#

class AccountBenefitPlan < ActiveRecord::Base
  include Propertied

  acts_as_paranoid

  belongs_to :account
  belongs_to :carrier
  belongs_to :carrier_account
  belongs_to :benefit_plan

  delegate :name, to: :benefit_plan
end
