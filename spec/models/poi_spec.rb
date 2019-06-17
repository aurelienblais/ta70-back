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
    it 'returns latitude' do
      expect(@object.lat).to eq(10.0)
    end
    it 'returns longitude' do
      expect(@object.lng).to eq(12.2)
    end
  end
end
