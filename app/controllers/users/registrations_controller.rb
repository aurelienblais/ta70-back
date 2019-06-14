# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  api :POST, '/users'
  param :user, Hash do
    param :email, String, required: true, desc: 'E-mail of the account to create'
    param :password, String, required: true, desc: 'Password of the account to create'
  end
  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end
end
