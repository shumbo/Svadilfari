import { ContentMessangerImpl } from "../messenger/ContentMessanger";
import { setupContentApp } from "./setup";

setupContentApp({
  messenger: new ContentMessangerImpl(),
  i18n: browser.i18n,
});
