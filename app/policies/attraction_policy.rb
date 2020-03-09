class AttractionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def create?
    user.present?
  end

  def show?
    true
  end

  def update?
    return true if user.present? && user == attraction.user
  end

  def destroy?
    return true if user.present? && user == attraction.user
  end

  def my_attractions?
    true
  end

  private

  def attraction
    record
  end
end
