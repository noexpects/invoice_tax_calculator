# frozen_string_literal: true

RSpec.describe Item do
  subject(:item) { described_class.new(quantity: quantity, name: name, price: price) }

  let(:quantity) { 2 }
  let(:name) { 'book' }
  let(:price) { 12.50 }
  let(:expected_sales_tax) { 5 }

  before do
    expect(TaxCalculator).to receive(:calculate).and_return(expected_sales_tax)
  end

  describe '#initialize' do
    it 'creates valid item' do
      expect(item.name).to eq(name)
      expect(item.price).to eq(price)
      expect(item.quantity).to eq(quantity)
      expect(item.sales_tax).to eq(expected_sales_tax)
    end
  end

  describe '#to_s' do
    let(:expected_string) { "#{quantity} #{name} at #{price}" }

    it 'returns valid string' do
      expect(item.to_s).to eq(expected_string)
    end
  end

  describe '#imported?' do
    context 'when Item contains imported in name' do
      let(:name) { 'imported book' }

      it 'returns true' do
        expect(item.imported?).to be(true)
      end
    end

    context 'when Item does not contain imported in name' do
      it 'returns false' do
        expect(item.imported?).to be(false)
      end
    end
  end

  describe '#total_price' do
    let(:expected_total_price) { (price * quantity) + expected_sales_tax }

    it 'returns valid total price' do
      expect(item.total_price).to eq(expected_total_price)
    end
  end
end
