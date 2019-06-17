# frozen_string_literal: true

require 'rails_helper'

describe Crawl do
  before do
    @object = FactoryBot.create(:crawl)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should have_one(:comment_thread) }
    it { should belong_to(:user) }
  end

  describe 'Validations' do
  end
end
