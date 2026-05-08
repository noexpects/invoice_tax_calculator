# frozen_string_literal: true

RSpec.describe Printer do
  describe '#print_message' do
    let(:expected_message) { "test\n" }
    let(:message) { 'test' }

    it 'puts passed message' do
      expect { described_class.new.print_message(message) }.to output(expected_message).to_stdout
    end
  end

  describe '#print_errors' do
    let(:errors) { %w[error1 error2] }
    let(:expected_message) { "Validation errors:\n- error1\n- error2\n" }

    it 'prints the errors' do
      expect { described_class.new.print_errors(errors) }.to output(expected_message).to_stdout
    end
  end

  describe '#print_items_list' do
    context 'when items present' do
      let(:items) { %w[item1 item2] }
      let(:expected_message) { "0: item1\n1: item2\n" }

      it 'prints the items list' do
        expect { described_class.new.print_items_list(items) }.to output(expected_message).to_stdout
      end
    end

    context 'when items are not present' do
      let(:items) { [] }
      let(:expected_message) { "No items in the list\n" }

      it 'prints message' do
        expect { described_class.new.print_items_list(items) }.to output(expected_message).to_stdout
      end
    end
  end

  describe '#print_deleted_item' do
    let(:item_name) { 'book' }
    let(:expected_message) { "Deleted: #{item_name}\n" }

    it 'prints message' do
      expect { described_class.new.print_deleted_item(item_name) }.to output(expected_message).to_stdout
    end
  end

  describe '#print_receipt' do
    let(:receipt) { Receipt.new }
    let(:item) { Item.new(quantity: 2, name: 'book', price: 12.50) }
    let(:expected_message) do
      "#{item.quantity} #{item.name}: #{format('%.2f', item.total_price)}\n" \
        "Sales Taxes: #{format('%.2f', receipt.sales_taxes)}\n" \
        "Total: #{format('%.2f', receipt.total)}\n"
    end

    before do
      receipt.items << item
    end

    it 'prints the receipt' do
      expect { described_class.new.print_receipt(receipt) }.to output(expected_message).to_stdout
    end
  end
end
