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

require 'spec_helper'

describe Feature do

  describe '#ensure_account_slugs' do

    it 'makes sure account slugs are not nil after create' do
      feature = Feature.create

      expect(feature.account_slugs).to eq([])
    end

    it 'makes sure account slugs are not nil after save' do
      feature = Feature.create \
        name: 'foo',
        account_slugs: %w[first_account]

      feature.account_slugs = nil

      expect(feature.account_slugs).to eq([])
    end

  end

  describe '#account_slugs' do

    it 'reads account slugs' do
      feature = Feature.new \
        account_slug_data: 'first_account, second_account'

      expect(feature.account_slugs).to eq(%w[first_account second_account])
    end

  end

  describe '#account_slugs=' do

    it 'sets account slugs' do
      feature = Feature.new
      feature.account_slugs = %w[second_account, third_account]

      expect(feature.account_slugs).to eq(%w[second_account, third_account])
    end

  end

end

