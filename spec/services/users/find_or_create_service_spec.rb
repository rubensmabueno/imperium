require 'rails_helper'

RSpec.describe Users::FindOrCreateService, type: :service do
  describe '.call' do
    let(:attributes) do
      {
        'provider' => 'provider',
        'uid' => 'uid',
        'info' => {
          'name' => 'name'
        }
      }
    end

    context 'when it finds a user' do
      let(:user) { build_stubbed(:user) }

      before do
        expect(User).to receive(:find_by).with(
          provider: 'provider', uid: 'uid'
        ) { user }
      end

      it 'calls on find_by and returns the user' do
        expect(described_class.call(attributes)).to eq(user)
      end
    end

    context "when it doesn't find a user" do
      let(:user) { build_stubbed(:user) }

      before do
        expect(User).to receive(:find_by).with(
          provider: 'provider', uid: 'uid'
        ) { nil }

        expect(User).to receive(:create!).with(
          provider: 'provider', uid: 'uid', name: 'name'
        ) { user }
      end

      it 'calls on create! and returns the user' do
        expect(described_class.call(attributes)).to eq(user)
      end
    end
  end
end
