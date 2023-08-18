# To deliver this notification:
#

# CommentNotification.with(comment: @comment).deliver_later(current_user)
# CommentNotification.with(comment: @comment).deliver(@comment.company.user)
# CommentNotification.with(comment: @comment).deliver(User.all)

# CommentNotification.with(company: @company).deliver(user)
# # Lookup Notifications where params: {post: @post}
# @post.notifications_as_company

# CommentNotification.with(parent: @company).deliver(user)
# @post.notifications_as_parent

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  deliver_by :email, mailer: "CommentMailer", if: :email_notifications?
  deliver_by :slack, debug: true
  deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  
  param :company

  # Define helper methods to make rendering easier.
  
  def message
    t(".message")
  end
  
  def email_notifications?
    !!recipient.preferences[:email]
  end
  def url
    post_path(params[:post])
  end
end
