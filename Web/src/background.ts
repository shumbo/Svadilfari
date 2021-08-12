import { ExecuteActionMessage, InternalMessage } from "./messenger/message";

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
      if (!sender?.tab?.id) {
        break;
      }
      const tabId = sender.tab.id;
      if (action.javascriptRun) {
        browser.tabs
          .executeScript(tabId, { code: action.javascriptRun.code })
          .then(() => {
            sendResponse(true);
          });
      }
      if (action.reload) {
        browser.tabs.reload(tabId).then(() => {
          sendResponse(true);
        });
      }
      if (action.tabClose) {
        browser.tabs.remove(tabId).then(() => {
          sendResponse(true);
        });
      }
      break;
    }
  }
  return true;
});
