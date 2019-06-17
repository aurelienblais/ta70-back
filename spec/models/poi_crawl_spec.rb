# frozen_string_literal: true

require 'rails_helper'

describe PoiCrawl do
  before do
    @object = FactoryBot.create(:poi_crawl)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:poi) }
    it { should belong_to(:crawl) }
  end

  describe 'Validations' do
  end
end
