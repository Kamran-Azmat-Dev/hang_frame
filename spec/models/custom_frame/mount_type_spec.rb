require 'rails_helper'

describe CustomFrame::MountType, type: :model do
  subject { described_class.new }

  describe '#uniq_custom_mount_type' do
    context 'create' do
      let(:create_attributes) { { name: 'custom', label: 'Custom' } }

      context 'without existing custom mount type' do
        it 'create custom mount type' do
          expect { described_class.create(create_attributes) }.to change { CustomFrame::MountType.all.size }.by(1)
        end
      end

      context 'with existing custom mount type' do
        let!(:custom_mount_type) { create(:custom_mount_type) }

        it 'don\'t create custom mount type' do
          result = described_class.create(create_attributes)

          expect(result.valid?).to eq false
          expect(result.errors.errors.first.type).to eq :taken
        end
      end
    end

    context 'update' do
      let!(:standard_mount_type) { create(:standard_mount_type) }
      let(:custom_attributes) { { name: 'custom' } }

      before { create(:custom_mount_type) }

      it 'don\'t allow update to custom when other exists' do
        expect { standard_mount_type.update!(custom_attributes) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
