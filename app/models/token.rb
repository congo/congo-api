# == Schema Information
#
# Table name: tokens
#
#  id         :integer          not null, primary key
#  name       :string
#  unique_id  :string
#  account_id :integer
#  created_at :datetime
#  updated_at :datetime
#  deleted_at :datetime
#
# Indexes
#
#  index_tokens_on_deleted_at  (deleted_at)
#

class Token < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :account

  before_save :ensure_unique_id

  def ensure_unique_id
    self.unique_id = ThirtySix.generate
  end
end

