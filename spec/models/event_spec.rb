# frozen_string_literal: true

require 'rails_helper'

describe Event do
  before do
    @object = FactoryBot.create(:event)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:poi) }
  end

  describe 'Validations' do
  end
end
