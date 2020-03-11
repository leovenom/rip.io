class MessagesController < ApplicationController
  before_action :authenticate_user!

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    @message.save!
    authorize @message

    redirect_to conversation_path(@conversation)
  end

  private
    def message_params
      params.require(:message).permit(:content)
    end
end
