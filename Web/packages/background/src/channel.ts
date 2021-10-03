/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
/* eslint-disable @typescript-eslint/no-explicit-any */
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
    console.log("send message to native", message);
    return browser.runtime.sendNativeMessage(message);
  }
  sendMessage(
    tabId: number,
    message: any,
    options?: Browser.Tabs.SendMessageOptionsType
  ): Promise<any> {
    console.log("send message", tabId, message);
    return browser.tabs.sendMessage(tabId, message, options);
  }
}
