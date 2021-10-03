import { Action, getActionCode } from "core";
import { unreachableCase } from "ts-assert-unreachable";
import { Browser } from "webextension-typedef";

import { findNext, findPrevious } from "./utils/find";

export type ExecuteAction = (
  action: Action,
  sender: Browser.Runtime.MessageSender
) => Promise<void>;

export async function executeAction(
  action: Action,
  sender: Browser.Runtime.MessageSender
): Promise<void> {
  const code = getActionCode(action);
  switch (code) {
    case "tabClose":
      if (!sender?.tab?.id) {
        break;
      }
      browser.tabs.remove(sender.tab.id);
      break;
    case "tabCloseAll": {
      const tabs = await browser.tabs.query({});
      const tabIds = tabs.map((t) => t.id).filter((id): id is number => !!id);
      await browser.tabs.remove(tabIds);
      break;
    }
    case "tabOpen":
      await browser.tabs.create({});
      break;
    case "tabDuplicate":
      if (!sender?.tab?.id) {
        break;
      }
      await browser.tabs.duplicate(sender.tab.id);
      break;
    case "tabNext": {
      if (!sender?.tab?.id) {
        break;
      }
      const tabs = await browser.tabs.query({});
      const tabIds = tabs.map((t) => t.id).filter((id): id is number => !!id);
      const nextTabId = findNext(tabIds, sender.tab.id);
      if (!nextTabId) {
        break;
      }
      await browser.tabs.update(nextTabId, { active: true });
      break;
    }
    case "tabPrevious": {
      if (!sender?.tab?.id) {
        break;
      }
      const tabs = await browser.tabs.query({});
      const tabIds = tabs.map((t) => t.id).filter((id): id is number => !!id);
      const previousTabId = findPrevious(tabIds, sender.tab.id);
      if (!previousTabId) {
        break;
      }
      await browser.tabs.update(previousTabId, { active: true });
      break;
    }
    case "reload":
      if (!sender?.tab?.id) {
        break;
      }
      browser.tabs.reload(sender.tab.id);
      break;
    case "javascriptRun": {
      if (!sender?.tab?.id || !action?.javascriptRun?.code) {
        break;
      }
      await browser.tabs.executeScript(sender?.tab?.id, {
        code: action.javascriptRun.code,
      });
      break;
    }
    case "urlCopy": {
      if (!sender?.tab?.id) {
        break;
      }
      await browser.tabs.executeScript(sender.tab.id, {
        code: `navigator.clipboard.writeText(location.href)`,
      });
      break;
    }
    case "scrollTop": {
      if (!sender?.tab?.id) {
        break;
      }
      await browser.tabs.executeScript(sender.tab.id, {
        code: `document.body.scrollIntoView({block: "start", inline: "nearest", smooth: true})`,
      });
      break;
    }
    case "scrollBottom": {
      if (!sender?.tab?.id) {
        break;
      }
      await browser.tabs.executeScript(sender.tab.id, {
        code: `document.body.scrollIntoView({block: "end", inline: "nearest", smooth: true})`,
      });
      break;
    }
    case null:
      break;
    default:
      unreachableCase(code);
  }
}
