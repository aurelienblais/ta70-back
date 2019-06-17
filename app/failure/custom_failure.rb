# frozen_string_literal: true

class CustomFailure < Devise::FailureApp
  def http_auth_body
    {
      errors: [
        {
          status: 401,
          title: 'Unauthorized',
          detail: 'User must be signed in to access this resource',
          code: '100'
        }
      ]
    }.to_json
  end
end
