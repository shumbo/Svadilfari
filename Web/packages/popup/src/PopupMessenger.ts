import {
  AddExclusionEntryRequest,
  GetExclusionEntryRequest,
  GetExclusionEntryResponse,
  RemoveExclusionEntryRequestMessage,
  AddExclusionEntryRequestMessage,
  PopupMessenger,
  GetExclusionEntryRequestMessage,
  ApplyExclusionEntryMessage,
} from "core";

export class PopupMessengerImpl implements PopupMessenger {
  async addExclusionEntry(req: AddExclusionEntryRequest): Promise<void> {
    const msg: AddExclusionEntryRequestMessage = {
      domain: req.domain,
      path: req.path,
      _tag: "ADD_EXCLUSION_ENTRY_REQUEST",
    };
    await browser.runtime.sendMessage(msg);
    await this.applyExclusionEntry();
  }
  async removeExclusionEntry(id: string): Promise<void> {
    const msg: RemoveExclusionEntryRequestMessage = {
      id,
      _tag: "REMOVE_EXCLUSION_ENTRY_REQUEST",
    };
    await browser.runtime.sendMessage(msg);
  }
  async getExclusionEntry(
    req: GetExclusionEntryRequest
  ): Promise<GetExclusionEntryResponse> {
    const msg: GetExclusionEntryRequestMessage = {
      domain: req.domain,
      path: req.path,
      _tag: "GET_EXCLUSION_ENTRY_REQUEST",
    };
    return await browser.runtime.sendMessage(msg);
  }
  async applyExclusionEntry(): Promise<void> {
    const tab = await browser.tabs.getCurrent();
    if (!tab.id) {
      return;
    }
    const msg: ApplyExclusionEntryMessage = { _tag: "APPLY_EXCLUSION_ENTRY" };
    await browser.tabs.sendMessage(tab.id, msg);
  }
}

export class DebugPopupMessenger implements PopupMessenger {
  constructor(private domain?: string, private path?: string) {}
  async addExclusionEntry(req: AddExclusionEntryRequest): Promise<void> {
    console.log("add exclusion entry");
    this.domain = req.domain;
    this.path = req.path;
  }
  async removeExclusionEntry(uuid: string): Promise<void> {
    console.log("remove exclusion entry ", uuid);
    this.domain = undefined;
    this.path = undefined;
  }
  async getExclusionEntry(
    req: GetExclusionEntryRequest
  ): Promise<GetExclusionEntryResponse> {
    if (this.domain === req.domain) {
      if (!this.path || this.path === req.path) {
        return {
          exclusionEntry: { domain: this.domain, path: this.path, id: "id" },
        };
      }
    }
    return {};
  }
  async applyExclusionEntry(): Promise<void> {
    console.log("apply exclusion entry");
  }
}
