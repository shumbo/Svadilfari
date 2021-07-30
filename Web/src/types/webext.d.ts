/**
 * Type definitions for WebExtension APIs
 * Based on https://github.com/kelseasy/web-ext-types/blob/master/global/index.d.ts with some modifications for Safari
 */

interface EventListener<T extends Function> {
  addListener: (callback: T) => void;
  removeListener: (listener: T) => void;
  hasListener: (listener: T) => boolean;
}

declare namespace browser.runtime {
  function sendMessage<T = unknown, U = unknown>(message: T): Promise<U>;
  function sendNativeMessage<T = unknown, U = unknown>(message: T): Promise<U>;
  type onMessageEvent = (
    message: unknown,
    sender: MessageSender,
    sendResponse: (response: unknown) => void
  ) => boolean | void;
  const onMessage: EventListener<onMessageEvent>;
}
