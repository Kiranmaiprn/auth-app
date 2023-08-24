class Comment < ApplicationRecord
  belongs_to :company
  belongs_to :user

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  private

  def notify_recipient
    CommentNotification.with(comment: self, company: company).deliver_later(company.user)

  end
  def cleanup_notifications
    notifications_as_comment.destroy_all

  end
end
