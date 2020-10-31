import consumer from "./consumer"
import { notification } from "../packs/notification";

consumer.subscriptions.create("BadgeNotificationsChannel", {
    connected() { console.log("Badge notifications channel connected"); },

    disconnected() { console.log("Badge notifications channel disconnected"); },

    received(data) {
        console.log("Badge notifications channel received data");
        notification(data.message, { type: 'primary', position: 'topright', closeBtn: true,  autoClose: 20000 })
    }
});
