# frozen_string_literal: true

class ApplicationController < ActionController::API
  # protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  include Authenticable

  protected

  def pagination(per_page, total_pages, total_count)
    {
      pagination: {
        per_page:,
        total_pages:,
        total_objects: total_count
      }
    }
  end

  private

  def record_not_found(exception)
    Rails.logger.error "Not Found #{exception.message}"
    render json: { error: exception.message }, status: :not_found
  end

  def record_invalid(exception)
    Rails.logger.error "Record Invalid. #{exception}"
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
