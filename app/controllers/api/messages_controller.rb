class Api::MessagesController < ApplicationController
  def index
    @chat_messages = Message.where("id > #{params[:id]}").where(group_id: params[:group_id])
  end
end