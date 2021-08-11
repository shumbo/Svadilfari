import { ContentMessangerImpl } from "./messenger/ContentMessanger";

console.log("hello from content");

const messanger = new ContentMessangerImpl();
messanger
  .getGesture()
  .then((x) => {
    console.log("loaded", x);
  })
  .catch((e) => {
    console.warn(e);
  });
