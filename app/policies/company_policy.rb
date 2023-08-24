class CompanyPolicy < ApplicationPolicy
    attr_reader :user, :company

    def initialize(user, company)
        @user=user
        @company=company
    end

    def update?
        user.admin? || !company.published?
    end

end