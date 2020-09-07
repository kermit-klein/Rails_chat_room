class SendMessageJob < ApplicationJob
  queue_as :default
  include CableReady::Broadcaster

  def perform(message)
    # mine = ApplicationController.render(
    #   partial: 'messages/mine',
    #   locals: { message: message }
    # )

    # theirs = ApplicationController.render(
    #   partial: 'messages/theirs',
    #   locals: { message: message }
    # )

    html = ApplicationController.render(
      partial: 'messages/theirs',
      locals: { message: message }
    )

    cable_ready["room_channel_#{message.room_id}"].insert_adjacent_html(
      selector: '#messages',
      position: 'beforeend',
      html: html,
      user_id: message.user_id
    )
    cable_ready.broadcast
  end
end
