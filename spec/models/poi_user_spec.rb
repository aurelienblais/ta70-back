# frozen_string_literal: true

require 'rails_helper'

describe PoiUser do
  before do
    @object = FactoryBot.create(:poi_user)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:poi) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
  end
end
