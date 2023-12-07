module Api
  module V0
    class VendorsController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response

      def index
        render json: VendorSerializer.new(Market.find(params[:market_id]).vendors)
      end

      def show
        render json: VendorSerializer.new(Vendor.find(params[:id]))
      end

      def create
        vendor = Vendor.create!(vendor_params)
        render json: VendorSerializer.new(vendor), status: :created
      end

      def destroy
        vendor = Vendor.find(params[:id])
        vendor.destroy
      end

      private

      def vendor_params
        params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
      end

      def record_invalid_response(exception)
        render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json, status: :bad_request
      end

      def not_found_response(exception)
        render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
      end
    end
  end
end
