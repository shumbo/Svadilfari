import { NativeProxyMessage } from "../messenger/message";
import { Convert, LoadSettingsResponse, MessageRequest } from "../SharedTypes";

export interface PopupMessenger {
  loadSettings(): Promise<LoadSettingsResponse>;
  updateExclusionList(exclusionList: string[]): Promise<void>;
}

export class PopupMessengerImpl implements PopupMessenger {
  async loadSettings(): Promise<LoadSettingsResponse> {
    const req: MessageRequest = { loadSettings: true };
    const msg: NativeProxyMessage = {
      type: "NATIVE_PROXY",
      payload: Convert.messageRequestToJson(req),
    };
    const responseStr = await browser.runtime.sendMessage(msg);
    const res: LoadSettingsResponse = Convert.toLoadSettingsResponse(
      responseStr as string
    );
    return res;
  }
  async updateExclusionList(exclusionList: string[]): Promise<void> {
    const req: MessageRequest = { updateExclusionList: { exclusionList } };
    const msg: NativeProxyMessage = {
      type: "NATIVE_PROXY",
      payload: Convert.messageRequestToJson(req),
    };
    await browser.runtime.sendMessage(msg);
  }
}

export class DebugPopupMessanger implements PopupMessenger {
  private exclusionList: string[];
  constructor(_exclusionList: string[] = []) {
    this.exclusionList = _exclusionList;
  }
  async loadSettings(): Promise<LoadSettingsResponse> {
    return { exclusionList: this.exclusionList, gestures: [] };
  }
  async updateExclusionList(exclusionList: string[]): Promise<void> {
    this.exclusionList = exclusionList;
  }
}
