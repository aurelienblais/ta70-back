# frozen_string_literal: true

require 'rails_helper'

describe Poi do
  before do
    @object = FactoryBot.create(:poi)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
  end

  describe 'Methods' do
    it 'returns parsed opening hours' do
      opening_hour = FactoryBot.create(:opening_hour)
      @object.opening_hours << opening_hour
      expect(@object.parsed_opening_hours).to eq([{ 1 => [{ opening: opening_hour.opening }] }])
    end
  end
end
