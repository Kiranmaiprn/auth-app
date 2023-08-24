class ApplicationController < ActionController::API
    before_action :authenticate_user!
     before_action :set_notifications, if: :current_user
    include Pundit::Authorization


# rescue_from Pundit::NotAuthorizedError, with: user_not_authorized

# private
# def user_not_authorized
#     flash[:alert]="you are not authorized to perform this action"
#     redirect_to root_path
# end
     private
     def set_notifications
        notifications=Notification.where(recipient: current_user).newest_first.limit(9)
        @unread=notifications.unread
        @read= notifications.read

     end



end
