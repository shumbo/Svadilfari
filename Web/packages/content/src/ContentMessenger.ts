import {
  Action,
  ContentMessenger,
  ExecuteActionMessage,
  Gesture,
  GestureChangeMessage,
  GestureReleaseMessage,
  GetCurrentTabExclusionEntryRequestMessage,
  GetExclusionEntryResponse,
  GetGestureRequestMessage,
  GetGestureResponse,
} from "core";

export class ContentMessengerImpl implements ContentMessenger {
  async executeAction(action: Action): Promise<void> {
    const msg: ExecuteActionMessage = {
      _tag: "EXECUTE_ACTION",
      action,
    };
    await browser.runtime.sendMessage(msg);
  }
  async getGesture(): Promise<GetGestureResponse> {
    const msg: GetGestureRequestMessage = {
      _tag: "GET_GESTURE_REQUEST",
    };
    const response = await browser.runtime.sendMessage(msg);
    return response;
  }
  async getCurrentTabExclusionEntry(): Promise<GetExclusionEntryResponse> {
    const msg: GetCurrentTabExclusionEntryRequestMessage = {
      _tag: "GET_CURRENT_TAB_EXCLUSION_ENTRY_REQUEST",
    };
    return await browser.runtime.sendMessage(msg);
  }
  async gestureChange(gesture: Gesture | null): Promise<void> {
    const msg: GestureChangeMessage = {
      _tag: "GESTURE_CHANGE",
      gesture,
    };
    await browser.runtime.sendMessage(msg);
  }
  async gestureRelease(gesture: Gesture | null): Promise<void> {
    const msg: GestureReleaseMessage = {
      _tag: "GESTURE_RELEASE",
      gesture,
    };
    await browser.runtime.sendMessage(msg);
  }
  onMessage(
    handler: (
      message:
        | GestureChangeMessage
        | GestureReleaseMessage
        | { _tag: "APPLY_EXCLUSION_ENTRY" }
    ) => void
  ): () => void {
    browser.runtime.onMessage.addListener(handler);
    return () => {
      browser.runtime.onMessage.removeListener(handler);
    };
  }
}

export class DebugContentMessenger implements ContentMessenger {
  async getGesture(): Promise<GetGestureResponse> {
    return {
      gestures: [
        {
          action: { tabClose: true },
          enabled: true,
          id: "close",
          pattern: {
            data: [
              { x: 0, y: 240 },
              { x: 240, y: 0 },
            ],
          },
        },
        {
          action: { tabCloseAll: true },
          enabled: true,
          id: "close all",
          pattern: {
            data: [
              { x: 0, y: 240 },
              { x: 240, y: 0 },
              { x: 0, y: -240 },
            ],
          },
        },
        {
          action: { reload: true },
          enabled: true,
          id: "reload",
          pattern: {
            data: [
              { x: -240, y: 0 },
              { x: 0, y: -240 },
            ],
          },
        },
      ],
    };
  }
  async getCurrentTabExclusionEntry(): Promise<GetExclusionEntryResponse> {
    return { exclusionEntry: undefined };
  }
  async gestureChange(gesture: Gesture | null): Promise<void> {
    console.log("gesture change");
  }
  async gestureRelease(gesture: Gesture | null): Promise<void> {
    console.log("gesture release");
  }
  async executeAction(action: Action): Promise<void> {
    console.log("execute action", action);
  }
  onMessage(): () => void {
    console.log("register handler");
    return () => {
      console.log("unregister handler");
    };
  }
}
