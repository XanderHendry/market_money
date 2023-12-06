module Api
  module V0
    class VendorsController < ApplicationController
      def index
        if Market.exists?(params[:market_id])
          render json: Market.find(params[:market_id]).vendors
        else
          render json: { errors: "Couldn't find Market with 'id'=#{params[:market_id]}" }, status: :not_found
        end
      end
    end
  end
end
