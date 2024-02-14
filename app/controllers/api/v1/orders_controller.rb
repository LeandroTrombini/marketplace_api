# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_with_token, only: %i[index]
      respond_to :json

      # GET /orders
      def index
        respond_with orders: current_user.orders
      end
    end
  end
end
