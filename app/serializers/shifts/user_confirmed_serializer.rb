module Shifts
  class UserConfirmedSerializer < BaseSerializer
    attributes :id, :name, :is_confirmed

    def name
      object.first_name&.capitalize
    end

    def is_confirmed
      Shifts::IsConfirmed.new(context[:shift], object.id).exists?
    end
  end
end