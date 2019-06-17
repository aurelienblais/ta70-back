# frozen_string_literal: true

require 'rails_helper'

describe OpeningHour do
  before do
    @object = FactoryBot.create(:opening_hour)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:poi) }
  end

  describe 'Validations' do
    it 'weekday is between 0 and 6' do
      expect(@object.weekday).to be_between 0, 6
    end
  end
end
