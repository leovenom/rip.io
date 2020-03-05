class PersonalityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def show?
    true
  end

  def update?
    return true if user.present? && user == personality.user
  end

  def destroy?
    return true if user.present? && user == personality.user
  end

  def my_personalities?
    true
  end

  private

  def personality
    record
  end

end
