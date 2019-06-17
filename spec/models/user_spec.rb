# frozen_string_literal: true

require 'rails_helper'

describe User do
  before do
    @object = FactoryBot.create(:user)
  end

  subject { @object }

  describe 'Factory' do
    it { should be_valid }
  end

  describe 'Associations' do
  end

  describe 'Validations' do
    it 'roles to be in enum' do
      expect(User::ROLES).to include @object.roles
    end
  end

  describe 'Methods' do
    it 'returns shorten name' do
      expect(@object.name).to eq "#{@object.firstname} L."
    end

    it 'returns user role' do
      expect(@object.user?).to be true
      expect(@object.admin?).to be false
    end
  end
end
