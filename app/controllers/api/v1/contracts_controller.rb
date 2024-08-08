class Api::V1::ContractsController < ApplicationController
  before_action :set_contract, only: %i[ show update destroy ]
  before_action :set_current_user, only: %i[index show create update destroy]

  include Authenticable

  def index
    @contracts = Contract.all

    render json: Panko::Response.new(
      data: Panko::ArraySerializer.new(
        @contracts,
        each_serializer: Contracts::ContractSerializer
      )
    ), status: :ok
  end

  def show
    render(
			json: Panko::Response.create do |r|
				{
					success: true,
					user: r.serializer(@contract, Contracts::ContractSerializer)
				}
			end, status: :ok
		)
  end

  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      render json: Contracts::ContractSerializer.new.serialize_to_json(@contract), status: :created
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contract.update(contract_params)
      render json: Contracts::ContractSerializer.new.serialize_to_json(@contract), status: :ok
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contract.destroy!
    head 204
  end

  private

    def set_contract
      @contract = Contract.find(params[:id])
    end

    def contract_params
      params.require(:contract).permit(:start_date, :end_date, :status, :company_id)
    end

    def set_current_user
      head :forbidden if current_user.nil?
      @current_user = current_user
    end
end
