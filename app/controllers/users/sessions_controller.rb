# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  api :POST, '/users/sign_in'
  param :user, Hash do
    param :email, String, required: true, desc: 'E-mail of the account'
    param :password, String, required: true, desc: 'Password of the account'
  end
  returns code: 200 do
    property :id, :number, desc: 'User id'
    property :email, String, desc: 'User email'
    property :firstname, String, desc: 'User firstname'
    property :lastname, String, desc: 'User lastname'
    property :token, String, desc: 'Token for next requests'
  end
  returns code: 400 do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end
  def create
    super
  end

  private

  def respond_with(resource, _opts = {})
    render json: resource.as_json.merge(token: request.env['warden-jwt_auth.token'])
  end

  def respond_to_on_destroy
    head :no_content
  end
end
