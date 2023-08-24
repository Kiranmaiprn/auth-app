class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true
  # belongs_to :account
  # acts_as_tenant :account
end
