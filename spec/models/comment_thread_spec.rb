# frozen_string_literal: true

require 'rails_helper'

describe CommentThread do
  before do
    @object = FactoryBot.create(:comment_thread)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
    it { should belong_to(:commentable) }
  end

  describe 'Methods' do
    it 'should be destroyed on commentable destruction' do
      expect { @object.commentable.destroy }.to change(CommentThread, :count).by(-1)
    end
  end
end
