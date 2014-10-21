require "#{Rails.root}/lib/sluggerizer"

class Account < ActiveRecord::Base
  has_many :account_users
  has_many :applications

  before_save :add_slug

  def add_slug
    self.slug = Sluggerizer.sluggerize(self.name) if self.name
  end

  def simple_hash
    {
      id: self.id,
      name: self.name,
      slug: self.slug,
      tagline: self.tagline
    }
  end
end

