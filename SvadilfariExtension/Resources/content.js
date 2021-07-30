(() => {
  // src/content.ts
  console.log("hello from content 333");
  browser.runtime.sendMessage({ greeting: "hello" }).then((response) => {
    console.log("Received response: ", response);
  });
  browser.runtime.onMessage.addListener((request) => {
    console.log("Received request: ", request);
  });
})();
