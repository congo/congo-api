# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  account_id    :integer
#  user_id       :integer
#  name          :string
#  english_name  :string
#  invitation_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  deleted_at    :datetime
#
# Indexes
#
#  index_roles_on_deleted_at  (deleted_at)
#

FactoryGirl.define do
  factory :role do
    user_id    1
    account_id 1
    name 'some_role'

    trait :admin do
      name 'admin'
    end

    trait :broker do
      name 'broker'
    end
  end
end
