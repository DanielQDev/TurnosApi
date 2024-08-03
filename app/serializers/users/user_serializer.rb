module Users
  class UserSerializer < BaseSerializer
    attributes :id, :email, :name, :role, :color

    def name
      "#{object.first_name} #{object.last_name}"
    end
  end
end