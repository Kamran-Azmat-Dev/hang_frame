require 'rails_helper'

describe CustomFrame::PrintSize, type: :model do
  subject { described_class.new }

  describe '#uniq_standard_mount_type' do
    let!(:standard_mount_type) { create(:standard_mount_type, width: 6.5) }
    let!(:standard_mount_type1) { create(:standard_mount_type, width: 8.0) }
    let(:medium_print_size) { build(:medium_print_size, mount_types: [standard_mount_type]) }

    context 'with existing Standard MountType' do
      it 'don\'t allow assign another Standard MountType' do
        expect do
          medium_print_size.mount_types << [standard_mount_type1]
          medium_print_size.save!
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'without defined Standard MountType' do
      let(:medium_print_size) { build(:medium_print_size, mount_types: []) }

      it 'allow assign Standard MountType' do
        expect(medium_print_size.mount_types).to eq []

        expect do
          medium_print_size.mount_types << [standard_mount_type]
          medium_print_size.save!
        end.to change { medium_print_size.mount_types.reload.size }.by(1)
      end
    end
  end

  describe '#require_standard_mount_type' do
    let!(:standard_mount_type) { create(:standard_mount_type, width: 6.5) }
    let!(:custom_mount_type) { create(:custom_mount_type) }

    context 'create' do
      let(:medium_print_size) { build(:medium_print_size) }

      it 'without MountType' do
        expect { medium_print_size.save! }.not_to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'only with Custom MountType' do
        expect do
          medium_print_size.mount_types << [custom_mount_type]
          medium_print_size.save!
        end.not_to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'with Standard and other MountTypes' do
        expect do
          medium_print_size.mount_types << [standard_mount_type, custom_mount_type]
          medium_print_size.save!
        end.not_to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'only with Standard MountType' do
        expect do
          medium_print_size.mount_types << [standard_mount_type]
          medium_print_size.save!
        end.not_to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
