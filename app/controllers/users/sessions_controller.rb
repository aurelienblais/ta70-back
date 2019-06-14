# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  api :POST, '/users/sign_in'
  param :user, Hash do
    param :email, String, required: true, desc: 'E-mail of the account'
    param :password, String, required: true, desc: 'Password of the account'
  end
  def create
    super
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
