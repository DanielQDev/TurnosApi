class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show update destroy ]
  before_action :set_current_user, only: %i[index create update show destroy]

  include Authenticable

  def index
    # ids = @current_user.shifts.pluck(:company_id).uniq
    @companies = Company.all

    render json: Panko::Response.new(
      data: Panko::ArraySerializer.new(
        @companies,
        each_serializer: Companies::CompanySerializer
      )
    ), status: :ok
  end

  def show
    render(
			json: Panko::Response.create do |r|
				{
					success: true,
					user: r.serializer(@company, Companies::CompanySerializer)
				}
			end, status: :ok
		)
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      render json: Companies::CompanySerializer.new.serialize_to_json(@company), status: :created
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def update
    if @company.update(company_params)
      render json: Companies::CompanySerializer.new.serialize_to_json(@company), status: :ok
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy!
    head 204
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :service)
    end

    def set_current_user
      @current_user = current_user
      head :forbidden if @current_user.nil?
    end
end
