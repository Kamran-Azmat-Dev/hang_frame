require 'rails_helper'

describe Spree::Cart::AddItem, type: :service do
  subject { described_class }

  context 'custom frame' do
    # rubocop:disable Layout/LineLength
    let(:order) { create :order }
    let(:hang_photo) { create(:hang_photo, type: 'custom', print_width: 20.0, print_height: 20.0) }
    let!(:moulding_type) { CustomFrame::MouldingType.create(name: 'Hardwood') }
    let!(:moulding_prices) { CustomFrame::MouldingTypePrice.create(print_size: print_size, moulding_type: moulding_type, price: 60.0) }
    let!(:mount_option) { create(:standard_mount_option) }
    let!(:mount_type) { create(:standard_mount_type) }
    let!(:custom_frame_product) { create(:product, custom: true, promotionable: true, price: 0.0, cost_price: nil, moulding_type: moulding_type) }
    let!(:print_size) do
      ps = build(:standard_print_size)
      ps.mount_types << mount_type
      ps.mount_options << mount_option
      ps.save!
      ps
    end
    # rubocop:enable Layout/LineLength

    let(:options) do
      ActionController::Parameters.new(
        hang_photo_uuid: hang_photo.uuid,
        print_size_id: print_size.id,
        mount_type_id: mount_type.id,
        mount_option_id: mount_option.id,
        mount_dimensions: {
          top: 6.5,
          left: 6.5,
          right: 6.5,
          bottom: 6.5
        }
      )
    end

    it 'add custom frame and update line_item price' do
      expect(order.line_items.count).to eq 0
      result = subject.call(order: order, variant: custom_frame_product.master, options: options)
      expect(result).to be_success
      expect(result.value.price).to eq result.value.order.line_item_adjustments.custom_frame.sum(:amount)
      expect(order.total).to eq result.value.order.line_item_adjustments.custom_frame.sum(:amount)
      expect(order.line_items.count).to eq 1
    end

    context 'applying promotion' do
      let(:promotion) { create(:promotion) }
      let(:calculator) { Spree::Calculator::FlatRate.new(preferred_amount: 10) }

      context 'one active order promotion' do
        # rubocop:disable Layout/LineLength
        let!(:action) { Spree::Promotion::Actions::CreateAdjustment.create(promotion: promotion, calculator: calculator) }
        # rubocop:enable Layout/LineLength

        before do
          subject.call(order: order, variant: custom_frame_product.master, options: options)
          order.reload
        end

        it 'creates valid discount on order' do
          subject.call(order: order, variant: custom_frame_product.master, options: options)
          expect(order.adjustments.to_a.sum(&:amount)).not_to eq 0
          expect(order.line_items.sum(&:amount)).to eq 160
          expect(order.total).to eq 150
        end
      end

      context 'adding donation product' do
        # rubocop:disable Layout/LineLength
        let!(:action) { Spree::Promotion::Actions::CreateAdjustment.create(promotion: promotion, calculator: calculator) }
        # rubocop:enable Layout/LineLength

        let!(:donation) { create :product, price: 6, is_donation: true }

        before do
          subject.call(order: order, variant: custom_frame_product.master, options: options)
          order.reload
        end

        it 'dont add promo adjustments' do
          expect(order.adjustments.sum(&:amount).to_s).to eq '-10.0'
          expect(order.total).to eq 70
          expect(order.adjustments.size).to eq 1
          subject.call(order: order, variant: donation.master, options: {})
          expect(order.adjustments.size).to eq 1
          expect(order.adjustments.sum(&:amount).to_s).to eq '-10.0'
          expect(order.total).to eq 76
        end
      end
    end
  end

  context 'standard frame' do
    let(:order) { create :order }
    let!(:product) { create(:product, price: 100) }
    let!(:option_types) do
      ['Moulding Type', 'Print Size', 'Mount Color'].each do |option|
        Spree::OptionType.create(name: option.downcase.gsub(' ', '_'), presentation: option)
      end
      Spree::OptionType.all
    end
    let(:taxonomy) { create(:taxonomy, name: 'Category') }
    let(:child_taxon) { create(:taxon, taxonomy: taxonomy, name: 'Standard') }
    let!(:standard_product) do
      product.taxons << child_taxon
      product.option_types << option_types
      product.save!
      product
    end

    it 'adding line item and update order total' do
      expect(order.line_items.count).to eq 0
      result = subject.call(order: order, variant: standard_product.master, options: {})
      expect(result).to be_success
      expect(order.total).to eq 100
    end

    context 'applying promotion' do
      let(:promotion) { create(:promotion) }
      let(:calculator) { Spree::Calculator::FlatRate.new(preferred_amount: 10) }

      context 'one active order promotion' do
        # rubocop:disable Layout/LineLength
        let!(:action) { Spree::Promotion::Actions::CreateAdjustment.create(promotion: promotion, calculator: calculator) }
        # rubocop:enable Layout/LineLength

        before do
          subject.call(order: order, variant: standard_product.master, options: {})
          order.reload
        end

        it 'creates valid discount on order' do
          subject.call(order: order, variant: standard_product.master, options: {})
          expect(order.adjustments.to_a.sum(&:amount)).not_to eq 0
          expect(order.line_items.sum(&:amount)).to eq 200
          expect(order.total).to eq 190
        end
      end

      context 'adding donation product' do
        # rubocop:disable Layout/LineLength
        let!(:action) { Spree::Promotion::Actions::CreateAdjustment.create(promotion: promotion, calculator: calculator) }
        # rubocop:enable Layout/LineLength
        let!(:donation) { create :product, price: 6, is_donation: true }
        before do
          subject.call(order: order, variant: standard_product.master, options: {})
          order.reload
        end

        it 'dont add promo adjustments' do
          expect(order.adjustments.sum(&:amount).to_s).to eq '-10.0'
          expect(order.total).to eq 90
          expect(order.adjustments.size).to eq 1
          subject.call(order: order, variant: donation.master, options: {})
          expect(order.adjustments.size).to eq 1
          expect(order.adjustments.sum(&:amount).to_s).to eq '-10.0'
          expect(order.total).to eq 96
        end
      end
    end
  end
end
