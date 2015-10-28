# == Schema Information
#
# Table name: memberships
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  user_id     :integer
#  group_id    :integer
#  role_name   :string
#  role_id     :integer
#  email       :string
#  email_token :string
#  created_at  :datetime
#  updated_at  :datetime
#  deleted_at  :datetime
#
# Indexes
#
#  index_memberships_on_deleted_at  (deleted_at)
#

FactoryGirl.define do
  factory :membership do
    group { create(:group) }
    email { Faker::Internet.email }
    role_name { "customer" }

    trait :with_user do
      user { create(:user, email: email) }
    end
  end
end
