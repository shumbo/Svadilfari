import { Action, ContentMessenger, getActionCode } from "core";

/**
 * execute or delegate action to be completed
 *
 * If action needs user-initiated context, it will be processed here
 * Otherwise, the action will be delegated to the background page
 */
export async function executeOrDelegateAction(
  action: Action,
  messenger: ContentMessenger
): Promise<void> {
  const code = getActionCode(action);
  switch (code) {
    case "share": {
      navigator.share({ url: location.href });
      break;
    }
    default: {
      messenger.executeAction(action);
      break;
    }
  }
}
