class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end


  end

  def index
    @user=current_user
    if @user.has_any_role? :admin, :super_admin
      render @user
    end
  end

  def edit
    update?
  end

  def update
    @user=current_user
    if @user.has_role? :admin
      render @user
    end
  end

  
end
