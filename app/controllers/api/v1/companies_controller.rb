class Api::V1::CompaniesController < ApiController

    before_action :set_company, only: [:show, :update, :destroy]
    def index
        @companies=current_user.companies
        render json: @companies
    end

    def show
        render json: @company, status: :ok
    end
    
    def create
        @company=current_user.companies.new(company_params)

        if @company.save
            render json: @company, status: :ok
        else
            render json: @company.errors, status: :unprocessable_entity
        end
    end

    def update
        if @company.update(company_params)
            render json: @company, status: :ok
        else
            render json: @company.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @company.destroy
            render json: {data: "company destroyed successfully", status: "success"}, status: :ok
        else
            render json: {data: "something went wrong", status: "failed"}
        end

    end

    private
    def set_company
        @company=current_user.companies.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
        render json: error.message, status: :unauthorized
    end

    def company_params
        params.require(:company).permit(:name, :address, :established_year)
    end

end
