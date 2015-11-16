# == Schema Information
#
# Table name: benefits_plans
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
#  index_benefits_plans_on_deleted_at  (deleted_at)
#

class BenefitsPlan < ActiveRecord::Base
  include Sluggable
  include Propertied

  acts_as_paranoid

  has_many :group_benefit_plans
  has_many :applications
  has_many :attachments
  has_many :account_benefit_plans

  belongs_to :account
  belongs_to :carrier_account
  belongs_to :carrier
end

