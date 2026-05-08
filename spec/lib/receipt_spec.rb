# frozen_string_literal: true

RSpec.describe Receipt do
  subject(:receipt) { Receipt.new }

  let(:item) { Item.new(quantity: 1, name: 'book', price: 12.49) }

  describe '#add_item' do
    it 'adds item to the list of items' do
      receipt.add_item(item)
      expect(receipt.items).to include(item)
    end
  end

  describe '#delete_item' do
    before do
      receipt.add_item(item)
    end

    it 'deletes item from the list of items' do
      receipt.delete_item(0)
      expect(receipt.items).not_to include(item)
    end
  end

  describe '#sales_taxes' do
    it 'returns the sum of sales taxes for all items' do
      receipt.add_item(item)
      expect(receipt.sales_taxes).to eq(item.sales_tax)
    end
  end

  describe '#total' do
    it 'returns the sum of total prices for all items' do
      receipt.add_item(item)
      expect(receipt.total).to eq(item.total_price)
    end
  end
end
