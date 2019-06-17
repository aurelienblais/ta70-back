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
      @object.opening_hours << FactoryBot.create(:opening_hour)
      expect(@object.parsed_opening_hours).to eq([{ 1 => [{ opening: '06:00' }] }])
    end
  end
end
