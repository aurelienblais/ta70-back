# frozen_string_literal: true

require 'rails_helper'

describe CrawlUser do
  before do
    @object = FactoryBot.create(:crawl_user)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:crawl) }
  end

  describe 'Validations' do
  end
end
