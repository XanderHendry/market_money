module Api
  module V0
    class MarketsController < ApplicationController
      def index
        render json: MarketSerializer.new(Market.all)
      end

      def show
        if Market.exists?(params[:id])
          render json: MarketSerializer.new(Market.find(params[:id]))
        else
          render json: { errors: "Couldn't find Market with 'id'=#{params[:id]}" }, status: :not_found
        end
        
      end
    end
  end
end
