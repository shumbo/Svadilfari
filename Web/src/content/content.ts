import { ContentMessangerImpl } from "../messenger/ContentMessanger";
import { setupContentApp } from "./setup";

console.log("hello from content");

setupContentApp({ contentMessenger: new ContentMessangerImpl() });
