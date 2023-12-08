module Api
  module V0
    class MarketsController < ApplicationController
      def index
        render json: MarketSerializer.new(Market.all)
      end

      def show
        render json: MarketSerializer.new(Market.find(params[:id]))
      end

      def search
        begin
          search_results = Market.search_by_fragment(query_params)
          # require 'pry'; binding.pry
          render json: MarketSerializer.new(search_results)
        rescue ActiveRecord::StatementInvalid => exception
          render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).serialize_json, status: :unprocessable_entity
        end
      end

      def nearest_atms
        market = Market.find(params[:id])
        render json: AtmSerializer.new(AtmService.new.atms_near_market(market))
      end

      private

      def query_params
        params.permit(:state, :city, :name)
      end
    end
  end
end
