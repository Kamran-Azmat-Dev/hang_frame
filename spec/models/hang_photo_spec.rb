require 'rails_helper'

describe HangPhoto, type: :model do
  context '#generate_uuid' do
    it 'update uuid field' do
      expect(subject.uuid).to eq nil
      subject.validate
      expect(subject.uuid).not_to eq nil
    end
  end
end
