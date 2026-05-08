# frozen_string_literal: true

RSpec.describe ValidationResult do
  subject(:validation_result) { described_class.new }

  let(:error) { 'error' }

  describe '#add_error' do
    it 'adds an error to the errors array' do
      validation_result.add_error(error)
      expect(validation_result.errors).to include(error)
    end
  end

  describe '#valid?' do
    context 'when there are no errors' do
      it 'returns true' do
        expect(validation_result.valid?).to be(true)
      end
    end

    context 'when there are some errors' do
      before do
        validation_result.add_error(error)
      end

      it 'returns false' do
        expect(validation_result.valid?).to be(false)
      end
    end
  end
end
