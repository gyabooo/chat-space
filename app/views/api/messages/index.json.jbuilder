json.array! @chat_messages do |message|
  json.message  message.body
  json.image    message.image
  json.date     message.created_at.strftime("%Y/%m/%d(%a) %H:%M:%S")
  json.username message.user.name
  json.id       message.id

  unless message.image.file.nil?
    json.image_alt message.image.filename.split(".")[0] if message.image.filename.present?
    json.image_thumb_alt File::basename(message.image.thumb.url).split(".")[0] if message.image.thumb.url.present?
  end
end