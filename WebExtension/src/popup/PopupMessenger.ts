import { NativeProxyMessage } from "../messenger/message";
import {
  Convert,
  GetExclusionEntryResponse,
  MessageRequest,
} from "../SharedTypes";

export interface PopupMessenger {
  getExclusionEntry(
    domain: string,
    path: string
  ): Promise<GetExclusionEntryResponse>;
  addExclusionEntry(domain: string, path: string | undefined): Promise<void>;
  removeExclusionEntry(uuid: string): Promise<void>;
}

export class PopupMessengerImpl implements PopupMessenger {
  /**
   * Notify updates of exclusion entry to the current tab
   */
  private async notifyExclusionEntryUpdate() {
    const tab = await browser.tabs.getCurrent();
    if (!tab.id) {
      return;
    }
    const msg = { type: "UPDATE_EXCLUSION_ENTRY" };
    await browser.tabs.sendMessage(tab.id, msg);
  }
  async getExclusionEntry(
    domain: string,
    path: string
  ): Promise<GetExclusionEntryResponse> {
    const req: MessageRequest = { getExclusionEntry: { domain, path } };
    const msg: NativeProxyMessage = {
      type: "NATIVE_PROXY",
      payload: Convert.messageRequestToJson(req),
    };
    const responseStr = await browser.runtime.sendMessage(msg);
    const res: GetExclusionEntryResponse = Convert.toGetExclusionEntryResponse(
      responseStr as string
    );
    return res;
  }
  async addExclusionEntry(
    domain: string,
    path: string | undefined
  ): Promise<void> {
    const req: MessageRequest = { addExclusionEntry: { domain, path } };
    const msg: NativeProxyMessage = {
      type: "NATIVE_PROXY",
      payload: Convert.messageRequestToJson(req),
    };

    // TODO: Error handling
    await browser.runtime.sendMessage(msg);

    await this.notifyExclusionEntryUpdate();
  }
  async removeExclusionEntry(uuid: string): Promise<void> {
    const req: MessageRequest = { removeExclusionEntry: uuid };
    const msg: NativeProxyMessage = {
      type: "NATIVE_PROXY",
      payload: Convert.messageRequestToJson(req),
    };

    // TODO: Error handling
    await browser.runtime.sendMessage(msg);

    await this.notifyExclusionEntryUpdate();
  }
}

export class DebugPopupMessanger implements PopupMessenger {
  private domain?: string;
  private path?: string;
  async getExclusionEntry(
    domain: string,
    path: string | undefined
  ): Promise<GetExclusionEntryResponse> {
    console.log("getExclusionEntry");
    if (this.domain === domain) {
      if (!this.path || this.path === path) {
        return {
          exclusionEntry: { domain: this.domain, path: this.path, id: "id" },
        };
      }
    }
    return {};
  }
  async addExclusionEntry(
    domain: string,
    path: string | undefined
  ): Promise<void> {
    console.log("addExclusionEntry");
    this.domain = domain;
    this.path = path;
  }
  async removeExclusionEntry(_: string): Promise<void> {
    console.log("removeExclusionEntry");
    this.domain = undefined;
    this.path = undefined;
  }
}
