class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def profile?
    true
  end

  def be_a_guide?
    true
  end

  def update_to_guide?
    true
  end
end
