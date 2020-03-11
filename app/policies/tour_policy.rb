class TourPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(guide: user)
    end
  end

  def index?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  def my_tours?
    true
  end

private

  def user_is_owner?
    record.guide == user
  end
end
