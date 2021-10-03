import {
  AddExclusionEntryRequestMessage,
  BackgroundMessenger,
  ExecuteActionMessage,
  GestureChangeMessage,
  GestureReleaseMessage,
  GetExclusionEntryRequestMessage,
  GetGestureRequestMessage,
  RemoveExclusionEntryRequestMessage,
} from "core";
import { Browser } from "webextension-typedef";

export class BackgroundMessengerImpl implements BackgroundMessenger {
  onMessage(
    handler: (
      msg:
        | GetGestureRequestMessage
        | AddExclusionEntryRequestMessage
        | RemoveExclusionEntryRequestMessage
        | GetExclusionEntryRequestMessage
        | GestureChangeMessage
        | GestureReleaseMessage
        | ExecuteActionMessage,
      sender: Browser.Runtime.MessageSender,
      // eslint-disable-next-line @typescript-eslint/no-explicit-any
      sendResponse: (...response: any[]) => void
    ) => void
  ): () => void {
    browser.runtime.onMessage.addListener(handler);
    return () => {
      browser.runtime.onMessage.removeListener(handler);
    };
  }
}
