import { urlToExclusionListEntry } from "../core/ExclusionList";
import { ExecuteActionMessage, InternalMessage } from "../messenger/message";
import {
  Convert,
  GetExclusionEntryResponse,
  MessageRequest,
} from "../SharedTypes";
import { assertUnreachable } from "../utils/assertUnreachable";
import { executeAction } from "./executeAction";

browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
  console.log("Received request: ", request);

  const req: InternalMessage = request as InternalMessage;
  switch (req.type) {
    case "NATIVE_PROXY": {
      browser.runtime.sendNativeMessage(req.payload).then((nativeResponse) => {
        sendResponse(nativeResponse);
      });
      break;
    }
    case "TOP_FRAME_PROXY": {
      if (!sender?.tab?.id) {
        break;
      }
      // FIXME: only send messages to the top frame
      browser.tabs.sendMessage(sender.tab.id, req.payload).then((response) => {
        sendResponse(response);
      });
      break;
    }
    case "EXECUTE_ACTION": {
      const msg = request as ExecuteActionMessage;
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
    case "GET_EXCLUSION_ENTRY":
      browser.tabs
        .getCurrent()
        .then((tab) => {
          const url = tab.url;
          if (!url) {
            sendResponse(false);
            return;
          }
          const currentTabEntry = urlToExclusionListEntry(url);
          const req: MessageRequest = {
            getExclusionEntry: {
              domain: currentTabEntry.domain,
              path: currentTabEntry.path,
            },
          };
          return browser.runtime.sendNativeMessage(
            Convert.messageRequestToJson(req)
          );
        })
        .then((responseStr: string) => {
          const res: GetExclusionEntryResponse =
            Convert.toGetExclusionEntryResponse(responseStr as string);
          sendResponse(res);
        });
      break;
    default:
      assertUnreachable(req);
      break;
  }
  return true;
});
