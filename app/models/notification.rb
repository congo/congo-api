# == Schema Information
#
# Table name: notifications
#
#  id           :integer          not null, primary key
#  account_id   :integer
#  role_id      :integer
#  subject_kind :string
#  subject_id   :integer
#  title        :string
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#  deleted_at   :datetime
#  read_at      :datetime
#
# Indexes
#
#  index_notifications_on_deleted_at  (deleted_at)
#  index_notifications_on_read_at     (read_at)
#

class Notification < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :account
  belongs_to :role

  def subject=(s)
    self.subject_kind = s.class.table_name
    self.subject_id = s.id
  end

  def subject
    self.subject_kind.classify.constantize.find(self.subject_id)
  end

  def mark_as_read
    self.read_at = Time.now
  end
end
