require 'rails_helper'

describe 'Api::HangPhotosController', type: :request do
  describe '#upload_photo' do
    let(:uploaded_image) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/image.jpg") }
    let(:invalid_uploaded_image) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/test.gif") }
    let(:params) { { photo: uploaded_image } }

    context 'with valid params' do
      before { post api_upload_hang_photo_path, params: params }

      it 'response with HTTP 201 status code' do
        expect(response.status).to eq 201
      end

      it 'response with uuid' do
        expect(JSON.parse(response.body)['data']['uuid']).to eq HangPhoto.first.uuid
      end
    end

    context 'with invalid params' do
      context 'without image file param' do
        before { post api_upload_hang_photo_path, params: params.merge!(photo: '') }

        it 'response with HTTP 422 status code' do
          expect(response.status).to eq 422
        end

        it 'response with proper error message' do
          # rubocop:disable Layout/LineLength
          expect(JSON.parse(response.body)['data']['errors']['photo'].first).to eq 'must be ActionDispatch::Http::UploadedFile'
          # rubocop:enable Layout/LineLength
        end
      end

      context 'with invalid image content type' do
        before { post api_upload_hang_photo_path, params: params.merge!(photo: invalid_uploaded_image) }

        it 'response with HTTP 422 status code' do
          expect(response.status).to eq 422
        end

        it 'return photo content type error' do
          expect(JSON.parse(response.body)['data']['errors'].include?('photo_content_type')).to eq true
        end
      end
    end
  end

  context '#crop_photo' do
    let(:photo) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/image.jpg") }
    let!(:hang_photo) { create(:hang_photo) }
    let(:params) do
      {
        uuid: hang_photo.uuid,
        width: 10,
        left: 3,
        top: 6,
        height: 2,
        type: 'standard',
        print_width: '10.5',
        print_height: '15.0'
      }
    end

    context 'with valid params' do
      before { post api_crop_hang_photo_path, params: params }

      it 'response with HTTP 200 status code' do
        expect(response.status).to eq 200
      end

      it 'response with photo uuid value' do
        expect(JSON.parse(response.body)['data']['uuid']).to eq hang_photo.uuid
      end
    end

    context 'with invalid params' do
      context 'missing params' do
        let(:errors_response) do
          {
            width: ['is missing'],
            left: ['is missing'],
            height: ['is missing'],
            top: ['is missing'],
            print_width: ['is missing'],
            print_height: ['is missing'],
            type: ['is missing']
          }.as_json
        end

        before { post api_crop_hang_photo_path, params: {} }

        it 'response with HTTP 422 status code' do
          expect(response.status).to eq 422
        end

        it 'response with error messages' do
          expect(JSON.parse(response.body)['data']['errors']).to eq errors_response
        end
      end

      context 'with negative crop details param' do
        before { post api_crop_hang_photo_path, params: params.merge!(left: -19, type: 'abc') }

        it 'response with HTTP 422 status code' do
          expect(response.status).to eq 422
        end

        it 'response with error message' do
          expect(JSON.parse(response.body)['data']['errors']['left'].first).to eq "value can't be negative"
          # rubocop:disable Layout/LineLength
          expect(JSON.parse(response.body)['data']['errors']['type'].first).to eq 'please choose: [standard/custom] type'
          # rubocop:enable Layout/LineLength
        end
      end

      context 'invalid uuid' do
        before { post api_crop_hang_photo_path, params: params.merge!(uuid: SecureRandom.uuid) }

        it 'response with HTTP 404 status code' do
          expect(response.status).to eq 404
        end
      end
    end
  end

  context '#photo' do
    let!(:hang_photo) { create(:hang_photo, cropped_photo: cropped_photo) }
    let(:cropped_photo) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/image.jpg") }
    let(:params) { { uuid: hang_photo.uuid } }

    context 'with valid params' do
      before { get api_show_hang_photo_path, params: params }

      it 'response with HTTP 200 status code' do
        expect(response.status).to eq 200
      end

      it 'return photo url' do
        expect(JSON.parse(response.body)['data']['photoUrl']).not_to be_empty
      end

      it 'returns cropped photo url' do
        expect(JSON.parse(response.body)['data']['croppedPhotoUrl']).not_to be_empty
      end
    end

    context 'with missing uuid' do
      context 'with missing param' do
        before { get api_show_hang_photo_path, params: params.merge!(uuid: nil) }

        it 'response with HTTP 404 status code' do
          expect(response.status).to eq 404
        end
      end

      context 'with invalid uuid' do
        before { get api_show_hang_photo_path, params: params.merge!(uuid: '222-222') }

        it 'response with HTTP 404 status code' do
          expect(response.status).to eq 404
        end

        it 'response with error message' do
          expect(JSON.parse(response.body)['data']['error']).to eq "Couldn't find HangPhoto"
        end
      end
    end
  end
end
