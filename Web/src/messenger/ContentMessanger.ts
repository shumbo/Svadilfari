import { ExecuteActionMessage, NativeProxyMessage } from "./message";
import {
  Action,
  Convert,
  GetGestureResponse,
  MessageRequest,
} from "../SharedTypes";

export interface ContentMessanger {
  getGesture(): Promise<GetGestureResponse>;
  executeAction(action: Action): Promise<void>;
}

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
}

export class DebugContentMessenger implements ContentMessanger {
  async getGesture(): Promise<GetGestureResponse> {
    return {
      gestures: [
        {
          action: { tabClose: { action: true } },
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
          action: { tabClose: { action: true } },
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
          action: { reload: { action: true } },
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
}
