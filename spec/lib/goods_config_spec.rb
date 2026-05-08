# frozen_string_literal: true

RSpec.describe GoodsConfig do
  describe '#basic_tax_rate' do
    let(:expected_rate) { 0.10 }

    it 'returns the correct basic tax rate' do
      expect(GoodsConfig.basic_tax_rate).to eq(expected_rate)
    end
  end

  describe '#import_duty_rate' do
    let(:expected_rate) { 0.05 }

    it 'returns the correct import duty rate' do
      expect(GoodsConfig.import_duty_rate).to eq(expected_rate)
    end
  end

  describe '#exempt?' do
    let(:name) { 'book' }

    context 'when item name is in exempt goods' do
      it 'returns true' do
        expect(GoodsConfig.exempt?(name)).to be true
      end
    end

    context 'when item name is not in exempt goods' do
      let(:name) { 'milk' }

      it 'returns false' do
        expect(GoodsConfig.exempt?(name)).to be false
      end
    end
  end

  describe '#valid_good?' do
    let(:name) { 'book' }

    context 'when item name is in goods list' do
      it 'returns true' do
        expect(GoodsConfig.valid_good?(name)).to be true
      end
    end

    context 'when item name is not in goods list' do
      let(:name) { 'milk' }

      it 'returns false' do
        expect(GoodsConfig.valid_good?(name)).to be false
      end
    end
  end
end
