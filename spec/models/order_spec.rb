require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'model scopes' do
    before do
      3.times do
        create(:order)
      end
      order = create(:order, :unshipped)
    end

    describe 'unshipped scope' do
      it 'returns the unshipped orders' do
        expect(Order.unshipped.count).to eq Order.where(shipped_at: nil).count
        expect(Order.unshipped).to eq Order.where(shipped_at: nil)
      end
    end

    describe 'shipped scope' do
      it 'returns the shipped orders in the correct order' do
        first_shipped = Order.where.not(shipped_at: nil).order(shipped_at: :asc).first
        last_shipped = Order.where.not(shipped_at: nil).order(shipped_at: :asc).last

        expect(Order.shipped.count).to eq Order.where.not(shipped_at: nil).count
        expect(Order.shipped.first).to eq first_shipped
        expect(Order.shipped.last).to eq last_shipped
      end
    end
  end

  describe '#shipped?' do
    it { is_expected.to respond_to(:shipped?) }

    context 'when a shipped date exists' do
      before { subject.update(shipped_at: Time.now) }
      it { is_expected.to be_shipped }
    end

    context 'when no shipped date is present' do
      it { is_expected.to_not be_shipped }
    end
  end

  describe '#settings' do
    it { is_expected.to respond_to(:settings) }

    context 'when expedite is present' do
      before { subject.settings(expedite: true) }
      it { is_expected.to be_expedited }
    end

    context 'when returns is present' do
      before { subject.settings(returns: true) }
      it { is_expected.to be_returnable }
    end

    context 'when warehouse is present' do
      before { subject.settings(warehouse: true) }
      it { is_expected.to be_warehoused }
    end
  end
end
