import { Browser } from "webextension-typedef";

export const mockTabsInstance = {
  async getCurrent() {
    return {
      url: "http://example.com",
    } as any;
  },
} as Browser.Tabs.Static;
