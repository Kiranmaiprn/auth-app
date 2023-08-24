class User < ApplicationRecord
  has_many :notifications, as: :recipient, dependent: :destroy


include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :jwt_authenticatable, jwt_revocation_strategy: self

   has_many :companies
   has_many :comments
   
   ROLES = %w{super_admin admin manager editor}
  def jwt_payload
    super
  end

  #writing methods reduces code
  ROLES.each do |role_name|
    define_method "#{role_name}?" do
       role == role_name
    end
  end


  # def super_admin?
  #   role == 'super_admin'
  # end

  # def admin?
  #   role == 'admin'
  # end

  # def manager?
  #   role == 'manager'
  # end

  # def editor?
  #   role  == 'editor'
  # end

  
         
end
