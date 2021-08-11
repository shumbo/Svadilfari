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
      }
    }
    return true;
  });
})();
