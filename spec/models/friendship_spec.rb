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

  describe 'Methods' do
    it 'returns waiting' do
      @object.update_attributes(accepted: false)
      expect(Friendship.waiting_for(@object.friend)).to include @object
      expect(Friendship.friend_for(@object.friend)).to eq []
    end

    it 'returns friends' do
      expect(Friendship.friend_for(@object.friend)).to include @object
      expect(Friendship.waiting_for(@object.friend)).to eq []
    end
  end
end
