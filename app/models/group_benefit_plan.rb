# == Schema Information
#
# Table name: group_benefit_plans
#
#  id              :integer          not null, primary key
#  account_id      :integer
#  group_id        :integer
#  benefit_plan_id :integer
#  properties_data :text
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#
# Indexes
#
#  index_group_benefit_plans_on_deleted_at  (deleted_at)
#

class GroupBenefitPlan < ActiveRecord::Base
  include Propertied

  acts_as_paranoid

  belongs_to :account
  belongs_to :group
  belongs_to :benefit_plan
end

