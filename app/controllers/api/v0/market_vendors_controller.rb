module Api
  module V0
    class MarketVendorsController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response
      rescue_from ActiveRecord::RecordNotUnique, with: :existing_record_response

      def create
        market_vendor = MarketVendor.create!(market_vendor_params)
        render json: MarketVendorSerializer.new(market_vendor), status: :created
      end

      private

      def market_vendor_params
        params.permit(:market_id, :vendor_id)
      end

      def not_found_response(exception)
        render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
      end

      def record_invalid_response(exception)
        render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json, status: :bad_request
      end

      def existing_record_response(exception)
        render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).serialize_json, status: :unprocessable_entity
      end
    end
  end
end
