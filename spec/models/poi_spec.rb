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
  end
end
