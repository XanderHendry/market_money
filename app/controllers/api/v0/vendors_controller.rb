module Api
  module V0
    class VendorsController < ApplicationController
      
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
      # rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response

      def index
        render json: VendorSerializer.new(Market.find(params[:market_id]).vendors)
      end

      def show
        render json: VendorSerializer.new(Vendor.find(params[:id]))
      end

      def create
        vendor = Vendor.create(vendor_params)
        if vendor.valid?
        render json: VendorSerializer.new(vendor), status: :created 
        else
        render json: ErrorSerializer.new(ErrorMessage.new(vendor.errors.full_messages, 400)).serialize_json, status: :bad_request
        end
      end

      private

      def vendor_params
        params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)  
      end

      # def record_invalid_response(exeption)
      #   render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json, status: :record_invalid
      # end

      def not_found_response(exception)
        render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
      end
    end
  end
end
