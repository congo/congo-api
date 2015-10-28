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

require 'spec_helper'

describe Group do
  it 'validates uniqueness of name' do
    Group.create(
      account_id: 5,
      name: "My group",
      is_enabled: nil,
      description_markdown: nil,
      description_html: ""
    )

    group = Group.create(
      account_id: 5,
      name: "My group",
      is_enabled: nil,
      description_markdown: nil,
      description_html: ""
    )

    expect(group.errors[:name]).to include("has already been taken")
  end
end
