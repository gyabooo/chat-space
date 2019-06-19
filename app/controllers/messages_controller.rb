class MessagesController < ApplicationController
  def index
    @chat_messages = Group.find(params[:group_id]).messages.includes(:user).order(created_at: :asc)
    # binding.pry
    @chat_message = Message.new(group_id: params[:group_id])
    # binding.pry
  end

  def create
    Message.create(message_params)
    redirect_to action: :index
  end

  private
  def message_params
    parameter = params.require(:message).permit(:body, :image)
    parameter.merge(group_id: params[:group_id], user_id: current_user.id)
  end
end
