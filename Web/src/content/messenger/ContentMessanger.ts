import { NativeProxyMessage } from "../../messenger/message";
import { Convert, GetGestureResponse, MessageRequest } from "../../SharedTypes";

interface ContentMessanger {
  getGesture(): Promise<GetGestureResponse>;
}

export class ContentMessangerImpl implements ContentMessanger {
  getGesture(): Promise<GetGestureResponse> {
    const req: MessageRequest = { getGestures: true };
    const msg: NativeProxyMessage = {
      type: "NATIVE_PROXY",
      payload: Convert.messageRequestToJson(req),
    };
    return browser.runtime.sendMessage(msg).then((responseStr) => {
      const res: GetGestureResponse = Convert.toGetGestureResponse(
        responseStr as string
      );
      return res;
    });
  }
}
