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

FactoryGirl.define do
  factory :carrier do
    name { Faker::Company.name }
    slug { name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') }
  end
end
