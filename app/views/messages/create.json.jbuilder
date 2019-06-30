json.message    @chat_message.body
json.username   @chat_message.user.name
json.date       @chat_message.created_at.strftime("%Y/%m/%d(%a) %H:%M:%S")
json.image      @chat_message.image
json.id         @chat_message.id

unless @chat_message.image.file.nil?
  json.image_alt @chat_message.image.filename.split(".")[0] if @chat_message.image.filename.present?
  json.image_thumb_alt File::basename(@chat_message.image.thumb.url).split(".")[0] if @chat_message.image.thumb.url.present?
end