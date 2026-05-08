# frozen_string_literal: true

RSpec.describe TaxCalculator do
  let(:basic_tax_rate) { 0.10 }
  let(:import_duty_rate ) { 0.05 }
  let(:expected_result) { 1.25 }

  describe 'Constants' do
    it { expect(described_class::ROUNDING_FACTOR).to eq(20.0) }
  end

  describe '#calculate' do
    let(:name) { 'book' }
    let(:price) { 12.50 }
    let(:quantity) { 1 }
    let(:item) { Item.new(quantity: quantity, name: name, price: price) }
    let(:exempt_result) { false }

    before do
      expect(GoodsConfig).to receive(:exempt?).twice.with(name).and_return(exempt_result)
    end

    context 'when item is exempted' do
      let(:exempt_result) { true }
      let(:expected_result) { 0 }

      it 'does not apply tax' do
        expect(described_class.calculate(item)).to eq(expected_result)
      end
    end

    context 'when item is imported' do
      let(:name) { 'imported book' }
      let(:expected_result) { 1.9 }

      it 'applies import duty' do
        expect(described_class.calculate(item)).to eq(expected_result)
      end
    end

    it 'applies basic tax for non-exempt item' do
      expect(described_class.calculate(item)).to eq(expected_result)
    end
  end
end
