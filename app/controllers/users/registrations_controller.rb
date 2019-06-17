# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  api :POST, '/users'
  param :user, Hash do
    param :email, String, required: true, desc: 'E-mail of the account to create'
    param :password, String, required: true, desc: 'Password of the account to create'
    param :firstname, String, required: true, desc: 'Firstname of the user'
    param :lastname, String, required: true, desc: 'Lastname of the user'
  end
  returns code: 200 do
    property :id, :number, desc: 'User id'
    property :email, String, desc: 'User email'
    property :firstname, String, desc: 'User firstname'
    property :lastname, String, desc: 'User lastname'
  end
  returns code: 400 do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end
end
