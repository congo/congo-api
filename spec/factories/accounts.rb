# == Schema Information
#
# Table name: accounts
#
#  id              :integer          not null, primary key
#  name            :string
#  slug            :string
#  tagline         :string
#  plan_name       :string
#  properties_data :text
#  card_number     :string
#  month           :string
#  year            :string
#  cvc             :string
#  billing_start   :datetime
#  billing_day     :integer
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#
# Indexes
#
#  index_accounts_on_deleted_at  (deleted_at)
#

FactoryGirl.define do
  factory :account do
    trait :admin do
      name       'Admin'
      tagline    'GroupHub administrative account'
      plan_name  'admin'
      properties { { name: 'Admin',
                     tagline: 'GroupHub administrative account',
                     plan_name: 'admin' } }
    end

    trait :broker do
      name       'First Account'
      tagline    '#1 Account'
      plan_name  'basic'
      properties { { name: 'First Account',
                     tagline: '#1 Account',
                     plan_name: 'basic' } }
    end
  end
end
