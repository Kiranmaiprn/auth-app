class CompanyController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  def index
    
    @companies = Company.all
    if current_user
      @notifications=current_user.notifications.reverse
      current_user.notifications.mark_as_read!
    end
    render json: @companies
  end

  def create
    @user=current_user
    @company=@user.companies.create(company_params)
    if @company.create
      render json: @company
    else
      render json: @company.errors
    end
  end

  def show
    @company=Company.find(params[:id])
    mark_notification_as_read
  end

  def update
  end

  def destroy
  end

  private
  def company_params
    params.require(:company).permit(:name, :address, :established_year)
  end

  def mark_notification_as_read
    if current_user
      notifications_to_mark_as_read = @company.notifications_as_company.where(recepient: current_user)
      notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
    end
  end
end
