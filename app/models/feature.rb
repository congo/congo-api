# == Schema Information
#
# Table name: features
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  enabled_for_all   :boolean
#  account_slug_data :text
#  created_at        :datetime
#  updated_at        :datetime
#  deleted_at        :datetime
#
# Indexes
#
#  index_features_on_deleted_at  (deleted_at)
#

class Feature < ActiveRecord::Base
  acts_as_paranoid

  before_save :ensure_account_slugs

  def ensure_account_slugs
    self.account_slugs ||= []
  end

  def account_slugs=(list)
    self.account_slug_data = (list || []).join(', ')
  end

  def account_slugs
    (self.account_slug_data || '').split(', ')
  end
end

