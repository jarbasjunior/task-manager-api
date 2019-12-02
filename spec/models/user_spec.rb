require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('email@email.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'returns email and created_at and token' do
      user.save!
      allow(Devise).to receive(:friendly_token).and_return('abc123xuzTOKEN')
      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xuzTOKEN")
    end
  end

  describe '#generate_authentication_token!' do
    it 'generates a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('abc123xuzTOKEN')
      user.generate_authentication_token!

      expect(user.auth_token).to eq('abc123xuzTOKEN')
    end

    it 'generates another auth token whe the current token already has been token' do
      allow(Devise).to receive(:friendly_token).and_return('abc123tokenxyz', 'abc123tokenxyz', 'abcXUZ123456789')
      existing_user = create(:user)
      user.generate_authentication_token!

      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end
end
