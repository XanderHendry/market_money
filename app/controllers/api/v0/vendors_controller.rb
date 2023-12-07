module Api
  module V0
    class VendorsController < ApplicationController
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

      def update
        vendor = Vendor.find(params[:id])
        vendor.update!(vendor_params)
        render json: VendorSerializer.new(vendor)
      end
      def destroy
        vendor = Vendor.find(params[:id])
        vendor.destroy
      end

      private

      def vendor_params
        params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
      end
    end
  end
end
