console.log("hello from background 333");

browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
  console.log("Received request: ", request);
  browser.runtime.sendNativeMessage({ native: "yo" }).then((nativeResponse) => {
    sendResponse(nativeResponse);
  });
  return true;
});
