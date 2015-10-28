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

class Group < ActiveRecord::Base
  include Sluggable
  include Propertied

  acts_as_paranoid

  has_many :memberships
  has_many :group_benefit_plans
  has_many :attachments

  belongs_to :account

  validates :name, uniqueness: true
end

