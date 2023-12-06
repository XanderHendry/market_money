module Api
  module V0
    class MarketsController < ApplicationController
      def index
        render json: Market.all
      end

      def show
        render json: market.find(params[:id])
      end

      def create
        render json: market.create(market_params)
      end

      def update
        render json: market.update(params[:id], market_params)
      end

      def destroy
        render json: market.delete(params[:id])
      end

      private

      def market_params
        params.require(:market).permit(:name, :street, :city, :county, :state, :zip, :lat, :lon)
      end
    end
  end
end
