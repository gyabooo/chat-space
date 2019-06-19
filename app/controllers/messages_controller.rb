class MessagesController < ApplicationController
  def index
    @chat_messages = Group.find(params[:group_id]).messages.includes(:user).order(created_at: :asc)
    @chat_message = Message.new(group_id: params[:group_id])
  end

  def create
    if Message.create(message_params).valid?
      redirect_to group_messages_path
    else
      redirect_to group_messages_path, alert: 'メッセージを入力してください。'
    end
  end

  private
  def message_params
    parameter = params.require(:message).permit(:body, :image)
    parameter.merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
