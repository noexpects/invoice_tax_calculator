# frozen_string_literal: true

RSpec.describe InputValidator do
  describe '#validate_input' do
    it 'returns error for empty input' do
      result = described_class.validate_input(' ')

      expect(result.valid?).to be false
      expect(result.errors).to include('Empty input')
    end
  end

  describe '#validate_add_item' do
    describe 'Success' do
      it 'parses valid input correctly' do
        result = described_class.validate_add_item('2 book at 12.49')

        expect(result.valid?).to be true
        expect(result.data[:quantity]).to eq(2)
        expect(result.data[:name]).to eq('book')
        expect(result.data[:price]).to eq(12.49)
      end
    end

    describe 'Failure' do
      it 'returns error for invalid format' do
        result = described_class.validate_add_item('invalid input')

        expect(result.valid?).to be false
        expect(result.errors).to include('Invalid input format')
      end

      it 'returns error for negative quantity' do
        result = described_class.validate_add_item('-1 book at 10')

        expect(result.valid?).to be false
        expect(result.errors).to include('Quantity must be greater than 0')
      end

      it 'returns error for invalid format' do
        result = described_class.validate_add_item('invalid input')

        expect(result.valid?).to be false
        expect(result.errors).to include('Invalid input format')
      end

      it 'returns error for invalid item entry' do
        result = described_class.validate_add_item('1 milk at 5')

        expect(result.valid?).to be false
        expect(result.errors).to include('Invalid item entries')
      end
    end
  end

  describe '#validate_delete_item' do
    let(:items) { ['item'] }

    it 'returns error for item not in the list' do
      result = described_class.validate_delete_item(2, items)

      expect(result.valid?).to be false
      expect(result.errors).to include('Item does not exist')
    end

    it 'returns error for negative index' do
      result = described_class.validate_delete_item(-1, items )

      expect(result.valid?).to be false
      expect(result.errors).to include('Invalid item index')
    end
  end
end
