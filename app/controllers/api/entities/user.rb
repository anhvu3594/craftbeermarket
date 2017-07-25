module API
  module Entities
    class User < Grape::Entity
      expose :id, documentation: { type: "Integer", desc: "User id" }
      expose :name, documentation: { type: "String", desc: "User name" }
      expose :email, documentation: { type: "String", desc: "User email" }
      expose :password_digest, documentation: { type: "String", desc: "User password" }
      expose :role, documentation: { type: "Integer", desc: "User role" }
    end

    class UserRequest < User
      unexpose :id
      unexpose :password_digest
      unexpose :role
      expose :password
    end

    class UserWithToken < User
      unexpose :id
      unexpose :password_digest
      expose :token, documentation: { type: "String", desc: "User token" }
    end
  end
end
