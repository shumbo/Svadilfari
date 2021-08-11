/**
 * Type definitions for WebExtension APIs
 * Based on https://github.com/kelseasy/web-ext-types/blob/master/global/index.d.ts with some modifications for Safari
 */

// eslint-disable-next-line @typescript-eslint/ban-types
interface EventListener<T extends Function> {
  addListener: (callback: T) => void;
  removeListener: (listener: T) => void;
  hasListener: (listener: T) => boolean;
}

declare namespace browser.runtime {
  export function sendMessage<T = unknown, U = unknown>(message: T): Promise<U>;
  export function sendNativeMessage<T = unknown, U = unknown>(
    message: T
  ): Promise<U>;
  type MessageSender = {
    tab?: browser.tabs.Tab;
    frameId?: number;
    id?: string;
    url?: string;
    tlsChannelId?: string;
  };
  type onMessageEvent = (
    message: unknown,
    sender: MessageSender,
    sendResponse: (response: unknown) => void
  ) => boolean | void;
  export const onMessage: EventListener<onMessageEvent>;
}

declare namespace browser.tabs {
  type Tab = {
    active: boolean;
    audible?: boolean;
    autoDiscardable?: boolean;
    cookieStoreId?: string;
    discarded?: boolean;
    favIconUrl?: string;
    height?: number;
    hidden: boolean;
    highlighted: boolean;
    id?: number;
    incognito: boolean;
    index: number;
    isArticle: boolean;
    isInReaderMode: boolean;
    lastAccessed: number;
    mutedInfo?: MutedInfo;
    openerTabId?: number;
    pinned: boolean;
    selected: boolean;
    sessionId?: string;
    status?: string;
    title?: string;
    url?: string;
    width?: number;
    windowId: number;
  };
  export function sendMessage<T = unknown, U = unknown>(
    tabId: number,
    message: T,
    options?: { frameId?: number }
  ): Promise<U>;
  export function reload(
    tabId?: number,
    reloadProperties?: { bypassCache?: boolean }
  ): Promise<void>;
  export function remove(tabIds: number | number[]): Promise<void>;
  export function executeScript(
    tabId: number | undefined,
    details: browser.extensionTypes.InjectDetails
  ): Promise<unknown[]>;
  export function getCurrent(): Promise<Tab>;
}
declare namespace browser.extensionTypes {
  type RunAt = "document_start" | "document_end" | "document_idle";
  export type InjectDetails = {
    allFrames?: boolean;
    code?: string;
    file?: string;
    frameId?: number;
    matchAboutBlank?: boolean;
    runAt?: RunAt;
  };
}
