# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit # Authorization system

  before_action :authenticate_user! # Ensure user is authenticated
  before_action :configure_permitted_parameters, if: :devise_controller? # Allow us to add custom fields to users

  # Render a 400 if any param is missing from an API call
  rescue_from Apipie::ParamMissing, ActiveRecord::RecordInvalid do |exception|
    # Moke a struct to mimic resource methods
    validation_error Struct.new(:errors).new(exception.to_s)
  end

  # Render a 403 if user is not allowed to perform action
  rescue_from Pundit::NotAuthorizedError do |exception|
    # Moke a struct to mimic resource methods
    validation_error Struct.new(:errors).new(exception.to_s), 403, 'Forbidden'
  end

  # Render a 404 if resource cannot be found
  rescue_from ActiveRecord::RecordNotFound do |exception|
    # Moke a struct to mimic resource methods
    validation_error Struct.new(:errors).new(exception.to_s), 404, 'Not found'
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
  def validation_error(resource, status = 400, title = 'Bad Request')
    render json: {
      errors: [
        {
          status: status,
          title: title,
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status:   status
  end

  protected

  # Add custom fields to users strong parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[firstname lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[firstname lastname])
  end
end
