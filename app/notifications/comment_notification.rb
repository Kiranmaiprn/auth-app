# To deliver this notification:
#

# CommentNotification.with(company: @company).deliver_later(current_user)
# # CommentNotification.with(comment: @comment).deliver(@comment.company.user)
# CommentNotification.with(company: @company).deliver_later(User.all)

# CommentNotification.with(company: @company).deliver(user)
# # Lookup Notifications where params: {post: @post}
# @post.notifications_as_company

# CommentNotification.with(parent: @company).deliver(user)
# @post.notifications_as_parent

class CommentNotification < Noticed::Base
  # Add your delivery methods
  
  deliver_by :database
  deliver_by :email, mailer: "CrudNotificationMailer"
  # deliver_by :action_cable
  # deliver_by :slack, debug: true
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  
  params :user

  def database
    {
      type: self.class.name, 
      params: params,
      # account: Current.account,
    }
  end

  # Define helper methods to make rendering easier.
  
  def message
   @company=Company.find(params[:comment][:company_id])
   @comment=Comment.find(params[:comment][:id])
   @user=User.find(@comment.user_id)
   "#{@user.email} commented on #{@company.name}"
  end
  
  # def email_notifications?
  #   !!recipient.preferences[:email]
  # end
  def url
    post_path(params[:comment][:company_id])
  end

  def comment
    params[:message]
  end

  def creator
    comment.user
  end

  def company
    comment.company
  
  end
end
# Notification.where(type: "CommentNotification".name)