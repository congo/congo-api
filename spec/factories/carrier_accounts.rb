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

FactoryGirl.define do
  factory :carrier_account do
    carrier { create(:carrier) }
    account { create(:account) }
    name { "#{account.name} - #{carrier.name}" }
  end
end
