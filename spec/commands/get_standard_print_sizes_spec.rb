require 'rails_helper'

describe GetStandardPrintSizes do
  subject { described_class.new.call }

  context 'when there is no print size option type' do
    it 'returns empty array' do
      expect(subject.items).to eq([])
    end
  end

  context 'when print size option type has no option values' do
    let!(:option_type) { create(:option_type, name: 'print_size') }

    it 'returns empty array' do
      expect(subject.items).to eq([])
    end
  end

  context 'when there is an option value that is not a dimension' do
    let!(:option_type) { create(:option_type, name: 'print_size', option_values: [option_value]) }
    let(:option_value) { build(:option_value, name: 'custom') }

    it 'skips this option value' do
      expect(subject.items).to eq([])
    end
  end

  context 'when there is an option value that is correct dimension' do
    let!(:option_type) { create(:option_type, name: 'print_size', option_values: [option_value]) }
    let(:option_value) { build(:option_value, name: '40x60') }

    it 'returns print size presenter for this value' do
      expect(subject.items.size).to eq(1)
      expect(subject.items[0].width).to eq(40)
      expect(subject.items[0].height).to eq(60)
    end
  end
end
