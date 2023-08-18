class Company < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :address, :established_year,presence: true

  has_many :notifications, as: :recipient, dependent: :destroy

  # Helper for associating and destroying Notification records where(params: {post: self})
  has_noticed_notifications

  # You can override the param_name, the notification model name, or disable the before_destroy callback
  has_noticed_notifications param_name: :parent, destroy: false, model_name: "Notification"

  
end
