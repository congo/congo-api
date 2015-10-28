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

FactoryGirl.define do
  factory :account_benefit_plan do
    account         { create(:account) }
    carrier         { create(:carrier) }
    carrier_account { create(:carrier_account, account: account, carrier: carrier) }
    benefit_plan    { create(:benefit_plan, carrier: carrier, account: account) }
  end
end
