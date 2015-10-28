# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  account_id      :integer
#  benefit_plan_id :integer
#  group_id        :integer
#  filename        :string
#  content_type    :string
#  title           :string
#  url             :string
#  description     :text
#  created_at      :datetime
#  updated_at      :datetime
#  deleted_at      :datetime
#
# Indexes
#
#  index_attachments_on_deleted_at  (deleted_at)
#

class Attachment < ActiveRecord::Base
  belongs_to :account
  belongs_to :benefit_plan

  acts_as_paranoid
end

