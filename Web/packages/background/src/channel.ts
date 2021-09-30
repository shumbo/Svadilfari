import { Browser } from "webextension-typedef";

export interface Channel {
  sendNativeMessage(message: any): Promise<any>;
  sendMessage(
    tabId: number,
    message: any,
    options?: Browser.Tabs.SendMessageOptionsType
  ): Promise<any>;
}

export class ChannelImpl implements Channel {
  sendNativeMessage(message: any): Promise<any> {
    return browser.runtime.sendNativeMessage(message);
  }
  sendMessage(
    tabId: number,
    message: any,
    options?: Browser.Tabs.SendMessageOptionsType
  ): Promise<any> {
    return browser.tabs.sendMessage(tabId, message, options);
  }
}
