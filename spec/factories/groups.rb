# == Schema Information
#
# Table name: groups
#
#  id                   :integer          not null, primary key
#  account_id           :integer
#  name                 :string
#  slug                 :string
#  is_enabled           :boolean
#  description_markdown :text
#  description_html     :text
#  properties_data      :text
#  created_at           :datetime
#  updated_at           :datetime
#  deleted_at           :datetime
#  number_of_members    :integer
#  industry             :string
#  website              :string
#  phone_number         :string
#  zip_code             :integer
#  tax_id               :integer
#
# Indexes
#
#  index_groups_on_deleted_at  (deleted_at)
#

FactoryGirl.define do
  group_properties = {
    name: 'My group',
    group_id: '1',
    tax_id: '123'
  }

  factory :group do
    account_id 1
    name  { Faker::Company.name }
    slug  { name.parameterize.underscore }
    is_enabled true
    description_markdown 'Some description'
    description_html 'Some description'
    properties_data group_properties
  end
end
