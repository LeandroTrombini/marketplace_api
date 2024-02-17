# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_with_token, only: %i[index show]
      respond_to :json

      # GET /orders
      def index
        respond_with orders: current_user.orders
      end

      # GET /orders/:id
      def show
        respond_with order: current_user.orders.find(params[:id])
      end
    end
  end
end
