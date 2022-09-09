module Api
  module Backend
    class SearchController < ApplicationController
      def mount_types
        @results = CustomFrame::MountType.search_by_name(params[:q][:name])

        render json: { mount_types: serialize_mount_types(@results) }, status: 200
      end

      def mount_options
        @results = CustomFrame::MountOption.search_by_name(params[:q][:name])

        render json: { mount_options: serialize_mount_options(@results) }, status: 200
      end

      def additionals
        @results = CustomFrame::Additional.search_by_name(params[:q][:name])

        render json: { additionals: serialize_additionals(@results) }, status: 200
      end

      private

      def serialize_mount_types(resource)
        CustomFrame::Admin::MountTypePresenter.new(collection: resource).to_json
      end

      def serialize_mount_options(resource)
        CustomFrame::Admin::MountOptionPresenter.new(collection: resource).to_json
      end

      def serialize_additionals(resource)
        CustomFrame::Admin::AdditionalPresenter.new(collection: resource).to_json
      end
    end
  end
end
