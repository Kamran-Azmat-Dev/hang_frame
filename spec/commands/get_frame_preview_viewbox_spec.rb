require 'rails_helper'

describe GetFramePreviewViewbox do
  subject { described_class.new.call(image) }

  let(:image) do
    double(
      attachment: attachment,
      preview_position_left: preview_position_left,
      preview_position_right: preview_position_right,
      preview_position_top: preview_position_top,
      preview_position_bottom: preview_position_bottom
    )
  end

  let(:attachment) { double(metadata: metadata) }
  let(:metadata) do
    {
      'width' => 100,
      'height' => 80
    }
  end

  let(:preview_position_left) { 20 }
  let(:preview_position_right) { 70 }
  let(:preview_position_top) { 15 }
  let(:preview_position_bottom) { 75 }

  let(:empty_viewbox) { FramePreviewViewbox.new(0, 0, 0, 0) }

  context 'when there is no attachment' do
    let(:attachment) { nil }

    it 'returns empty viewbox' do
      expect(subject).to eq(empty_viewbox)
    end
  end

  context 'when attachment has no metadata' do
    let(:attachment) { double(metadata: nil) }

    it 'returns empty viewbox' do
      expect(subject).to eq(empty_viewbox)
    end
  end

  context 'when attachment lacks dimension' do
    let(:metadata) do
      {
        'width' => 100
      }
    end

    it 'returns empty viewbox' do
      expect(subject).to eq(empty_viewbox)
    end
  end

  context 'when preview position is missing' do
    let(:preview_position_right) { nil }

    it 'returns empty viewbox' do
      expect(subject).to eq(empty_viewbox)
    end
  end

  context 'when image has metadata and preview position is set' do
    let(:expected_viewbox) do
      FramePreviewViewbox.new(200, 188, 500, 750)
    end

    it 'returns expected viewbox' do
      expect(subject).to eq(expected_viewbox)
    end
  end
end
