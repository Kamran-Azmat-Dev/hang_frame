require 'rails_helper'

describe Spree::Stock::Coordinator, type: :model do
  describe '#shipments' do
    context 'when there are two line items of the same variant inside an order' do
      let(:variant) { create(:variant) }
      let(:line_item1) { create(:line_item, variant: variant) }
      let(:line_item2) { create(:line_item, variant: variant) }

      let(:line_items) { [line_item1, line_item2] }
      let(:order) { create(:order, line_items: line_items) }

      subject { described_class.new(order).shipments }

      it 'returns a shipment with two inventory units for both line items' do
        expect(subject.count).to eq(1)

        first_shipment = subject.first
        expect(first_shipment.inventory_units.size).to eq(2)

        line_item1_unit = first_shipment.inventory_units.find { |e| e.line_item == line_item1 }
        line_item2_unit = first_shipment.inventory_units.find { |e| e.line_item == line_item2 }
        expect(line_item1_unit).to_not be_nil
        expect(line_item2_unit).to_not be_nil
      end
    end
  end
end
