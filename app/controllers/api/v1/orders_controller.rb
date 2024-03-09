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

      # POST /orders
      def create
        order = current_user.orders.build
        order.build_placements_with_product_ids_and_quantities(params[:order][:product_ids_and_quantities])

        return render json: { errors: order.errors }, status: 422 unless order.save

        order.reload
        OrderMailer.send_confirmation(order).deliver_now
        render json: { order:, products: order.products }, status: 201
      end

      private

      def order_params
        params.require(:order).permit(product_ids: [])
      end
    end
  end
end
