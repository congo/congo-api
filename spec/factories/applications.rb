# == Schema Information
#
# Table name: applications
#
#  id                 :integer          not null, primary key
#  account_id         :integer
#  benefit_plan_id    :integer
#  membership_id      :integer
#  reference_number   :string
#  properties_data    :text
#  selected_by_id     :integer
#  selected_on        :datetime
#  applied_by_id      :integer
#  applied_on         :datetime
#  declined_by_id     :integer
#  declined_on        :datetime
#  approved_by_id     :integer
#  approved_on        :datetime
#  submitted_by_id    :integer
#  submitted_on       :datetime
#  completed_by_id    :integer
#  completed_on       :datetime
#  errored_by_id      :boolean
#  errored_on         :datetime
#  activity_id        :string
#  created_at         :datetime
#  updated_at         :datetime
#  deleted_at         :datetime
#  pdf_attachment_url :string
#
# Indexes
#
#  index_applications_on_deleted_at  (deleted_at)
#

FactoryGirl.define do
  factory :application do
  end
end
