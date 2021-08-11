(() => {
  // src/background.ts
  browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
    const req = request;
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
        browser.tabs.sendMessage(sender.tab.id, req.payload, { frameId: 0 }).then((response) => {
          sendResponse(response);
        });
        break;
      }
      case "EXECUTE_ACTION": {
        const msg = request;
        const action = msg.action;
        if (!sender?.tab?.id) {
          break;
        }
        const tabId = sender.tab.id;
        if (action.runJavascript) {
          browser.tabs.executeScript(tabId, { code: action.runJavascript.code }).then(() => {
            sendResponse(true);
          });
        }
        if (action.reload) {
          browser.tabs.reload(tabId).then(() => {
            sendResponse(true);
          });
        }
        if (!!action.tabClose) {
          browser.tabs.remove(tabId).then(() => {
            sendResponse(true);
          });
        }
        break;
      }
    }
    return true;
  });
})();
