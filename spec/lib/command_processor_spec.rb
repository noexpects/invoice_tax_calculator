# frozen_string_literal: true

RSpec.describe CommandProcessor do
  let(:processor) { CommandProcessor.new }
  let(:receipt) { processor.receipt }
  let(:printer) { processor.printer }

  describe '#initialize' do
    it 'creates a new receipt' do
      expect(receipt).to be_a(Receipt)
      expect(receipt.items).to be_empty
    end

    it 'creates a new printer' do
      expect(printer).to be_a(Printer)
    end
  end

  describe '#process' do
    context 'with empty input' do
      it 'returns nil and prints validation errors' do
        expect(printer).to receive(:print_errors)
        expect(processor.process('')).to be_nil
      end
    end

    context 'with nil input' do
      it 'returns nil and prints validation errors' do
        expect(printer).to receive(:print_errors)
        expect(processor.process(nil)).to be_nil
      end
    end

    context 'with whitespace-only input' do
      it 'returns nil and prints validation errors' do
        expect(printer).to receive(:print_errors)
        expect(processor.process('   ')).to be_nil
      end
    end

    context 'with add_item command' do
      it 'processes valid add item command' do
        expect(printer).to receive(:print_message).with('Item added')
        processor.process('add_item 1 book at 12.49')
      end

      it 'handles invalid add item format' do
        expect(printer).to receive(:print_errors)
        processor.process('add_item invalid format')
      end

      it 'handles invalid item data' do
        expect(printer).to receive(:print_errors)
        processor.process('add_item -1 book at 12.49')
      end
    end

    context 'with list_items command' do
      let(:items) { %w[item1 item2] }

      it 'lists items when list is empty' do
        expect(printer).to receive(:print_items_list).with([])
        processor.process('list_items')
      end

      it 'lists items when list has items' do
        allow(receipt).to receive(:items).and_return(items)
        expect(printer).to receive(:print_items_list).with(items)
        processor.process('list_items')
      end
    end

    context 'with delete_item command' do
      let(:item) { Item.new(quantity: 1, name: 'book', price: 12.49) }

      it 'deletes valid item index' do
        allow(receipt).to receive(:items).and_return([item])
        allow(receipt).to receive(:delete_item).with(0).and_return(item)
        
        expect(printer).to receive(:print_deleted_item).with('book')
        processor.process('delete_item 0')
      end

      it 'handles invalid item index' do
        allow(receipt).to receive(:items).and_return([])
        expect(printer).to receive(:print_errors)
        processor.process('delete_item 0')
      end

      it 'handles negative item index' do
        allow(receipt).to receive(:items).and_return([item])
        expect(printer).to receive(:print_errors)
        processor.process('delete_item -1')
      end
    end

    context 'with generate_invoice command' do
      it 'generates invoice receipt' do
        expect(printer).to receive(:print_receipt).with(receipt)
        processor.process('generate_invoice')
      end
    end

    context 'with unknown command' do
      it 'prints unknown command message' do
        expect(printer).to receive(:print_message).with('Unknown command')
        processor.process('unknown_command')
      end
    end
  end
end
