require 'rails_helper'

describe Spree::OrderDecorator, type: :model do
  let(:order) { create(:order, email: 'test@example.com') }

  context '#finalize' do
    before do
      order.update_column :state, 'complete'
    end

    context '#deliver_donation_confirmation_email' do
      it 'send confirmation email' do
        mail_message = double 'Mail::Message'
        allow(order).to receive_messages(donated?: true)
        expect(Spree::DonationMailer).to receive(:confirm).with(order: order).and_return mail_message
        order.finalize!
      end

      it 'don\'t send confirmation email' do
        allow(order).to receive_messages(donated?: false)
        expect(Spree::DonationMailer).not_to receive(:confirm)
        order.finalize!
      end
    end

    context '#dontaed?' do
      context 'with donate line_item' do
        let!(:product) { create(:product, is_donation: true) }
        let!(:variant) { create(:variant, product: product) }
        before do
          order.line_items.new(variant: variant, quantity: 1)
          order.save!
        end

        it 'return true' do
          expect(order.donated?).to eq true
        end
      end

      context 'wihout donate line_item' do
        let!(:product) { create(:product, is_donation: false) }
        let!(:variant) { create(:variant, product: product) }
        before do
          order.line_items.new(variant: variant, quantity: 1)
          order.save!
        end

        it 'return false' do
          expect(order.donated?).to eq false
        end
      end
    end
  end
end
