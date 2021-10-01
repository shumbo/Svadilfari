import { ContentMessengerImpl } from "./ContentMessenger";
import { setupContentApp } from "./setup";

setupContentApp({
  messenger: new ContentMessengerImpl(),
  i18n: browser.i18n,
});
