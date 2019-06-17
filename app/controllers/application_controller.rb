# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user! # Ensure user is authenticated
  before_action :configure_permitted_parameters, if: :devise_controller? # Allow us to add custom fields to users

  # Render a 400 if any param is missing from an API call
  rescue_from Apipie::ParamMissing do |exception|
    # Moke a struct to mimic resource methods
    validation_error Struct.new(:errors).new(exception.to_s)
  end

  # Generic renderer for Devise gem (users)
  def render_resource(resource)
    # Render as JSON the resources
    if resource.errors.empty?
      render json: resource
    else
      # In case of error, return it
      validation_error(resource)
    end
  end

  # Return any error (except missing params) as JSON
  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status:   :bad_request
  end

  protected

  # Add custom fields to users strong parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[firstname lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[firstname lastname])
  end
end
