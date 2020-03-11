class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = policy_scope(Conversation).where("guide_id = ? OR user_id = ?", current_user.id, current_user.id)
    @users = policy_scope(User).where.not(id: current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation
    @messages = policy_scope(@conversation.messages)
    @messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)
  end

  def create
    if Conversation.between(params[:guide_id], params[:user_id]).present?
      @conversation = Conversation.between(params[:guide_id], params[:user_id]).first
      authorize @conversation
    else
      @conversation = Conversation.create!(conversation_params)
      authorize @conversation
    end

    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:guide_id, :user_id)
    end
end
