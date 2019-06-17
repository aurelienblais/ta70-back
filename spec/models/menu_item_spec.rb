# frozen_string_literal: true

require 'rails_helper'

describe MenuItem do
  before do
    @object = FactoryBot.create(:menu_item)
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
