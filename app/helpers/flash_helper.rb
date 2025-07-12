module FlashHelper
  def flash_turbo_stream
    turbo_stream.replace("flash_messages", partial: "shared/flash")
  end
end
