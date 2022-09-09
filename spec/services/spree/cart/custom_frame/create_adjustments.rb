require 'rails_helper'

describe Spree::Cart::CustomFrame::CreateAdjustments, type: :service do
  subject { described_class.call(line_item: line_item, payload: payload[:adjustments].as_json) }

  describe 'custom frame' do
    let!(:hang_photo) { create(:hang_photo) }
    let!(:mount_type) { create(:standard_mount_type) }
    let!(:mount_option) { create(:standard_mount_option) }
    let!(:additional) { create(:foil_blocking) }
    let(:print_size) do
      ps = build(:standard_print_size)
      ps.mount_types << mount_type
      ps.mount_options << mount_option
      ps.additionals << additional
      ps.save!
      ps
    end

    let!(:line_item) { create(:line_item, hang_photo_id: hang_photo.id, print_size_id: print_size.id) }

    describe 'create_adjustments' do
      context 'with proper payload' do
        let(:payload) do
          {
            adjustments:
              {
                mount_type_id: mount_type.id,
                mount_option_id: mount_option.id,
                additionals: [additional.id]
              }
          }
        end

        it 'create adjustments' do
          expect(line_item.adjustments).to eq []
          subject
          expect(line_item.adjustments.reload).not_to eq []
          expect(subject.success).to eq true
        end
      end

      context 'with missing payload' do
        let(:payload) { { adjustments: {} } }

        it 'return failure' do
          subject
          expect(subject.success).to eq false
          expect(line_item.adjustments).to eq []
        end
      end
    end
  end

  describe 'standard frame' do
    let!(:hang_photo) { create(:hang_photo) }
    let!(:line_item) { create(:line_item, hang_photo_id: hang_photo.id) }
    let(:payload) { { adjustments: {} } }

    it 'don\'t create adjustments' do
      expect(line_item.adjustments).to eq []
      subject
      expect(line_item.adjustments).to eq []
      expect(subject.success).to eq false
    end
  end
end
