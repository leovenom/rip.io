class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_tour, only: [:create, :new]

  def index
    @conversations = policy_scope(Conversation).where("guide_id = ? OR user_id = ?", current_user.id, current_user.id)
    @users = policy_scope(User).where.not(id: current_user.id)
  end

  def new
    @conversation = Conversation.new
    authorize @conversation
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation
    @messages = policy_scope(@conversation.messages)
    @messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)
  end

  def create
    if Conversation.find_by(guide: @tour.guide).present?
      @conversation = Conversation.find_by(guide: @tour.guide)
    else
      @conversation = Conversation.create!(guide: @tour.guide, user: current_user)
    end
    authorize @conversation


    @conversation.messages.create(user: current_user, content: params[:message][:content])

    redirect_to conversation_path(@conversation)
  end

  private

  def fetch_tour
    @tour = Tour.find(params[:tour_id])
  end
end
