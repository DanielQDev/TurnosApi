module Contracts
  class ContractSerializer < BaseSerializer
    attributes :id, :start_date, :end_date, :status
  end
end