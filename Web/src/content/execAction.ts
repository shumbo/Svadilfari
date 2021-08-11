import { Action } from "../SharedTypes";

async function execAction(action: Action) {
  if (action.tabClose) {
    const t = await browser.tabs.getCurrent();
    if (!t.id) {
      return;
    }
    await browser.tabs.remove(t.id);
  }
}
