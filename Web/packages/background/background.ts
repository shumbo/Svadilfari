import {
  BackgroundMessenger,
  Convert,
  MessageRequest,
  urlToExclusionListEntry,
} from "core";
import { Channel } from "./channel";
import { ExecuteAction } from "./executeAction";
import { unreachableCase } from "ts-assert-unreachable";

type Deps = {
  messenger: BackgroundMessenger;
  channel: Channel;
  executeAction: ExecuteAction;
};

export function startBackground({ channel, messenger, executeAction }: Deps) {
  messenger.onMessage((msg, sender, sendResponse) => {
    /**
     * A helper function that encodes MessageRequest and sends it to the backend
     * @param msgReq Message Request
     */
    const handleMessageToNative = async (msgReq: MessageRequest) => {
      const response = await channel.sendNativeMessage(
        Convert.messageRequestToJson(msgReq)
      );
      sendResponse(response);
    };

    /**
     * A helper function that sends a message to the sender's tab
     * @param msg Message
     */
    const handleMessageToContent = async (msg: unknown) => {
      if (!sender.tab?.id) {
        return;
      }
      const response = await channel.sendMessage(sender.tab.id, msg);
      sendResponse(response);
    };

    switch (msg._tag) {
      case "EXECUTE_ACTION": {
        const action = msg.action;
        executeAction(action, sender)
          .then(() => {
            sendResponse(true);
          })
          .catch(() => {
            sendResponse(false);
          });
        break;
      }
      case "GET_EXCLUSION_ENTRY_REQUEST": {
        browser.tabs
          .getCurrent()
          .then((tab) => {
            const url = tab.url;
            if (!url) {
              sendResponse(false);
              return;
            }
            const currentTabEntry = urlToExclusionListEntry(url);
            handleMessageToNative({
              getExclusionEntry: {
                domain: currentTabEntry.domain,
                path: currentTabEntry.path,
              },
            });
          })
          .catch(() => {
            sendResponse(false);
          });
        break;
      }
      case "GET_GESTURE_REQUEST": {
        handleMessageToNative({ getGestures: true });
        break;
      }
      case "ADD_EXCLUSION_ENTRY_REQUEST": {
        handleMessageToNative({
          addExclusionEntry: { domain: msg.domain, path: msg.path },
        });
        break;
      }
      case "REMOVE_EXCLUSION_ENTRY_REQUEST": {
        handleMessageToNative({ removeExclusionEntry: { id: msg.id } });
        break;
      }
      case "GESTURE_CHANGE": {
        handleMessageToContent(msg);
        break;
      }
      case "GESTURE_RELEASE": {
        handleMessageToContent(msg);
        break;
      }
      default:
        unreachableCase(msg);
    }
  });
}
