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
          market = Market.search_by_fragment(query_params)
          render json: MarketSerializer.new(market)
        rescue ActiveRecord::StatementInvalid => exception
          render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).serialize_json, status: :unprocessable_entity
        end
      end

      private

      def query_params
        params.permit(:state, :city, :name)
      end
    end
  end
end
