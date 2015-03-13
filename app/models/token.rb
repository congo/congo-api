class Token < ActiveRecord::Base
  belongs_to :account

  before_save :ensure_unique_id

  def ensure_unique_id
    self.unique_id = SecureRandom.uuid.gsub('-', '')
  end
end

