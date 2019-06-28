class MessagesController < ApplicationController
  before_action :set_group

  def index
    @chat_messages = @group.messages.includes(:user)
    @chat_message = Message.new
  end

  def create
    @chat_message = @group.messages.new(message_params)
    respond_to do |format|
      if @chat_message.save
        format.html { redirect_to group_messages_path, notice: 'メッセージが送信されました' }
        format.json
      else
        format.html {
          @chat_messages = @group.messages.includes(:user)
          flash.now[:alert] = 'メッセージを入力してください。'
          render :index
        }
        format.json
      end
    end
  end

  private
  def message_params
    parameter = params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end
