class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.present?
  end

  def create?
    user.present?
  end

  def conversation
    record
  end

  def show?
    user.present?
  end
end
