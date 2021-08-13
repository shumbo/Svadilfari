import { ExecuteActionMessage, InternalMessage } from "../messenger/message";
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
  }
  return true;
});
