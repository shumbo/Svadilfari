import { Browser } from "webextension-typedef";

export interface PopupTabManager {
  getCurrentTab(): Promise<Browser.Tabs.Tab>;
}

export class PopupTabManagerImpl implements PopupTabManager {
  async getCurrentTab(): Promise<Browser.Tabs.Tab> {
    const currentTab = await browser.tabs.getCurrent();
    return currentTab;
  }
}

export class DebugPopupTabManager implements PopupTabManager {
  async getCurrentTab(): Promise<Browser.Tabs.Tab> {
    return { url: "http://example.com/foo" } as Browser.Tabs.Tab;
  }
}
