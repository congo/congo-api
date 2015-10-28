# == Schema Information
#
# Table name: benefit_plans
#
#  id                   :integer          not null, primary key
#  account_id           :integer
#  carrier_account_id   :integer
#  carrier_id           :integer
#  name                 :string
#  slug                 :string
#  is_enabled           :boolean
#  description_markdown :text
#  description_html     :text
#  properties_data      :text
#  created_at           :datetime
#  updated_at           :datetime
#  deleted_at           :datetime
#
# Indexes
#
#  index_benefit_plans_on_deleted_at  (deleted_at)
#

FactoryGirl.define do
  factory :benefit_plan do
    account { create(:account) }
    carrier { create(:carrier) }
    carrier_account { create(:carrier_account, account: account, carrier: carrier) }
    name { "Best Health Insurance PPO" }
    slug { "best_health_insurance_ppo" }
    is_enabled { true }
    description_markdown { "# Best Health Insurance PPO\n\nAn example plan." }
    description_html { "<h1>Best Health Insurance PPO</h1>\n<p>An example plan.</p>" }
  end
end
