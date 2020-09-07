import consumer from "./consumer";
import CableReady from "cable_ready";

document.addEventListener("turbolinks:load", () => {
  const room_element = document.getElementById("room-id");
  const room_id = Number(room_element.getAttribute("data-room-id"));

  consumer.subscriptions.subscriptions.forEach((subscription) => {
    if (JSON.parse(subscription.identifier.channel == "RoomChannel")) {
      consumer.subscriptions.remove(subscription);
    }
  });

  consumer.subscriptions.create(
    { channel: "RoomChannel", room_id: room_id },
    {
      connected() {
        console.log("connected to " + room_id);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        CableReady.perform(data.operations);
      },
    }
  );
});
