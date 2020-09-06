import consumer from "./consumer";

consumer.subscriptions.create("ActivityChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    this.perform("appear");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    let elements = document.getElementsByClassName(
      `user-${data.user_id}-status`
    );
    Array.from(elements, (element) => {
      if (data.status == "online") {
        element.classList.add("online");
      } else {
        element.classList.remove("online");
      }
    });
  },
});
