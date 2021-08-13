import {
  ExecuteActionMessage,
  NativeProxyMessage,
  TopFrameProxyMessage,
} from "./message";
import {
  Action,
  Convert,
  Gesture,
  GetGestureResponse,
  MessageRequest,
} from "../SharedTypes";
import { isEmbededFrame } from "../content/utils/isEmbedFrame";
import { noop } from "../utils/noop";

export interface ContentMessanger {
  /**
   * Get list of configured gestures from native extension
   */
  getGesture(): Promise<GetGestureResponse>;
  /**
   * Execute an action
   * @param action action
   */
  executeAction(action: Action): Promise<void>;
  /**
   * Forward the change of gesture to the top frame
   * @param gesture
   */
  forwardGestureChange(gesture: Gesture | null): Promise<void>;
  /**
   * Forward the release of gesture to the top frame
   * @param gesture
   */
  forwardGestureRelease(gesture: Gesture | null): Promise<void>;
  /**
   * register event listener for GestureChange
   * *only works on top frame
   * @param handler
   * @return call to unbind the listener
   */
  onGestureChange(handler: (gesture: Gesture | null) => void): () => void;
  /**
   * register event listener for GestureRelease
   * *only works on top frame
   * @param handler
   * @return call to unbind the listener
   */
  onGestureRelease(handler: (gesture: Gesture | null) => void): () => void;
}

/**
 * Structure used within ContentMessanger to communicate between frames
 */
type ForwardMessage =
  | {
      type: "GESTURE_CHANGE";
      gesture: Gesture | null;
    }
  | {
      type: "GESTURE_RELEASE";
      gesture: Gesture | null;
    };

export class ContentMessangerImpl implements ContentMessanger {
  async getGesture(): Promise<GetGestureResponse> {
    const req: MessageRequest = { getGestures: true };
    const msg: NativeProxyMessage = {
      type: "NATIVE_PROXY",
      payload: Convert.messageRequestToJson(req),
    };
    const responseStr = await browser.runtime.sendMessage(msg);
    const res: GetGestureResponse = Convert.toGetGestureResponse(
      responseStr as string
    );
    return res;
  }
  async executeAction(action: Action): Promise<void> {
    const msg: ExecuteActionMessage = {
      type: "EXECUTE_ACTION",
      action,
    };
    await browser.runtime.sendMessage(msg);
  }
  async forwardGestureChange(gesture: Gesture | null): Promise<void> {
    const forwardMsg: ForwardMessage = {
      type: "GESTURE_CHANGE",
      gesture,
    };
    const msg: TopFrameProxyMessage = {
      type: "TOP_FRAME_PROXY",
      payload: forwardMsg,
    };
    await browser.runtime.sendMessage(msg);
  }
  async forwardGestureRelease(gesture: Gesture | null): Promise<void> {
    const forwardMsg: ForwardMessage = {
      type: "GESTURE_RELEASE",
      gesture,
    };
    const msg: TopFrameProxyMessage = {
      type: "TOP_FRAME_PROXY",
      payload: forwardMsg,
    };
    await browser.runtime.sendMessage(msg);
  }
  onGestureChange(handler: (gesture: Gesture | null) => void): () => void {
    if (isEmbededFrame()) {
      return noop;
    }
    const listener = (message: unknown) => {
      console.log("onGestureChange", message);
      const payload = message as ForwardMessage;
      if (payload.type !== "GESTURE_CHANGE") {
        return;
      }
      handler(payload.gesture);
    };
    browser.runtime.onMessage.addListener(listener);
    return () => {
      browser.runtime.onMessage.removeListener(listener);
    };
  }
  onGestureRelease(handler: (gesture: Gesture | null) => void): () => void {
    if (isEmbededFrame()) {
      return noop;
    }
    const listener = (message: unknown) => {
      const payload = message as ForwardMessage;
      if (payload.type !== "GESTURE_RELEASE") {
        return;
      }
      handler(payload.gesture);
    };
    browser.runtime.onMessage.addListener(listener);
    return () => {
      browser.runtime.onMessage.removeListener(listener);
    };
  }
}

export class DebugContentMessenger implements ContentMessanger {
  async getGesture(): Promise<GetGestureResponse> {
    return {
      gestures: [
        {
          action: { tabClose: true },
          enabled: true,
          fingers: 1,
          id: "close",
          pattern: {
            data: [
              { x: 0, y: 240 },
              { x: 240, y: 0 },
            ],
          },
        },
        {
          action: { tabOpen: true },
          enabled: true,
          fingers: 1,
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
          fingers: 1,
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
  async executeAction(action: Action): Promise<void> {
    console.log("execute", action);
  }
  async forwardGestureChange(gesture: Gesture | null): Promise<void> {
    console.log("forwardGestureChange", gesture);
  }
  async forwardGestureRelease(gesture: Gesture | null): Promise<void> {
    console.log("forwardGestureRelease", gesture);
  }
  onGestureChange(_: (_: Gesture | null) => void): () => void {
    return noop;
  }
  onGestureRelease(_: (_: Gesture | null) => void): () => void {
    return noop;
  }
}
