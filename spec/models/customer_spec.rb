require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    describe 'presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    describe 'length' do
      it { is_expected.to validate_length_of(:name).is_at_most(40) }
      it { is_expected.to validate_length_of(:email).is_at_most(255) }
      it { is_expected.to validate_length_of(:password).is_at_least(8) }
    end

    describe 'emoji' do
      it do
        is_expected.to_not allow_values('🍣').for(:name)
      end
    end

    describe 'email characters' do
      it do
        is_expected.to allow_values('first.last@foo.jp',
                                    'user@example.com',
                                    'USER@foo.COM',
                                    'A_US-ER@foo.bar.org',
                                    'alice+bob@baz.cn').for(:email)
      end

      it do
        is_expected.to_not allow_values('user@example,com',
                                        'user_at_foo.org',
                                        'user.name@example.',
                                        'foo@bar_baz.com',
                                        'foo@bar+baz.com').for(:email)
      end
    end

    describe 'uniqueness of email' do
      let!(:customer) { create(:customer, email: 'original@example.com') }
      it 'is invalid with a duplicate email' do
        customer = build(:customer, email: 'original@example.com')
        expect(customer).to_not be_valid
      end

      it 'is case insensitive in email' do
        customer = build(:customer, email: 'ORIGINAL@EXAMPLE.COM')
        expect(customer).to_not be_valid
      end
    end
  end
end
