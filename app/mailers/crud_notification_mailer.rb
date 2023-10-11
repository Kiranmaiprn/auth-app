class CrudNotificationMailer < ApplicationMailer


  def create_notification(object)
    @object  = object
    
    mail to: @object.email, 
    subject: "a new entry for #{@object.class} has been created", 
    body: "a new entry for #{@object.class} has been created"
  end

 
  def update_notification(object)
    @object  = object
    @object_count = object.class.count
    
    mail to: 'k50194204@gmail.com', subject: "a new entry for #{object.class} has been updated"
    
  end

  
  def delete_notification(object)
    @object  = object
    @object_count = object.class.count
    
    mail to: 'k50194204@gmail.com', subject: "a new entry for #{object.class} has been deleted"

  end


  def comment_notification
    @user=params[:user]
    mail to: @user.email,
    subject: "a new entry for  has been created", 
    body: "Hi #{@user.name} with email #{@user.email}
         Thank you for registering with us
         A new user signed up with a new account"
  end
end
