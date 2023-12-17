# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json

      def index
        respond_with User.all
      end

      def show
        respond_with User.find(params[:id])
      end

      def create
        user = User.create(user_params)

        if user.save
          render json: user, status: 201, location: [:api, user]
        else
          render json: { errors: user.errors }, status: 422
        end
      end

      def update
        user = User.find(params[:id])

        if user.update(user_params)
          render json: user, status: :ok, location: [:api, user]
        else
          render json: { errors: user.errors }, status: 422
        end
      end

      def destroy
        user = User.find(params[:id])

        if user.destroy
          render status: 204
        else
          render json: { errors: 'It was not possible to delete the user.' }, status: 422
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
