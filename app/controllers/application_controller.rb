class ApplicationController < ActionController::API
    before_action :authenticate_user!
# #   include Pundit::Authorization

# rescue_from Pundit::NotAuthorizedError, with: user_not_authorized

# private
# def user_not_authorized
#     flash[:alert]="you are not authorized to perform this action"
#     redirect_to root_path
# end

end
