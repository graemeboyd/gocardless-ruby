module Grapi
  class User < Resource
    ENDPOINT = '/users/:id'

    attr_accessor :name, :first_name, :last_name, :email, :display_name
    date_accessor :created_at
  end
end
