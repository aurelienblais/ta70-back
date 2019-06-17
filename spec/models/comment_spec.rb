# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  before do
    @object = FactoryBot.create(:comment)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:comment_thread) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
  end
end
