import { Action } from "../SharedTypes";
import { assertUnreachable } from "../utils/assertUnreachable";
import { getActionCode } from "../utils/getActionCode";

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
    case "tabCloseAll":
      break;
    case "tabOpen":
      break;
    case "tabDuplicate":
      break;
    case "tabNext":
      break;
    case "tabPrevious":
      break;
    case "reload":
      break;
    case "javascriptRun": {
      break;
    }
    case "urlCopy":
      break;
    case "share":
      break;
    case "scrollTop":
      break;
    case "scrollBottom":
      break;
    case null:
      break;
    default:
      assertUnreachable(code);
  }
}
