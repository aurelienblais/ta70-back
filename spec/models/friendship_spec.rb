# frozen_string_literal: true

require 'rails_helper'

describe Friendship do
  before do
    @object = FactoryBot.create(:friendship)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end

  describe 'Validations' do
  end
end
