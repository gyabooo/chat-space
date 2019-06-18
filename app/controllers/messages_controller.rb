class MessagesController < ApplicationController
  def index
    @chat_messages = Message.where(group_id: params[:group_id])
  end

  def create
    Message.create(message_params)
    redirect_to action: :index
  end

  private
  def message_params
    params.permit(:body, :group_id).merge(user_id: current_user.id)
  end
end
