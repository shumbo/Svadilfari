/* eslint-disable @typescript-eslint/no-explicit-any */
import { describe, test, expect, beforeEach, vi, type Mock } from "vitest";
import {
  Action,
  AddExclusionEntryRequestMessage,
  BackgroundMessenger,
  Convert,
  ExecuteActionMessage,
  Gesture,
  GestureChangeMessage,
  GestureReleaseMessage,
  GetExclusionEntryRequestMessage,
  GetGestureRequestMessage,
  RemoveExclusionEntryRequestMessage,
} from "core";
import { Browser } from "webextension-typedef";

import { startBackground } from "./background";
import type { Channel } from "./channel";
import type { ExecuteAction } from "./executeAction";

const TAB_ID = 1;

describe("Background", () => {
  let sendMockMessage: (msg: any) => void;
  let sendResponseMock: Mock<(...response: any[]) => void>;
  let sendMessageToContent: Mock<Channel["sendMessage"]>;
  let sendMessageToNative: Mock<Channel["sendNativeMessage"]>;
  let executeAction: Mock<ExecuteAction>;
  beforeEach(() => {
    sendResponseMock = vi.fn<(...response: any[]) => void>();
    sendMessageToContent = vi.fn<Channel["sendMessage"]>();
    sendMessageToNative = vi.fn<Channel["sendNativeMessage"]>();
    executeAction = vi
      .fn<ExecuteAction>()
      .mockImplementation(() => Promise.resolve());
    class MockBackgroundMessenger implements BackgroundMessenger {
      onMessage(
        handler: (
          msg:
            | GetGestureRequestMessage
            | AddExclusionEntryRequestMessage
            | RemoveExclusionEntryRequestMessage
            | GetExclusionEntryRequestMessage
            | GestureChangeMessage
            | GestureReleaseMessage
            | ExecuteActionMessage,
          sender: Browser.Runtime.MessageSender,
          sendResponse: (...response: any[]) => void,
        ) => void,
      ): () => void {
        sendMockMessage = (msg) => {
          handler(
            msg,
            { tab: { id: TAB_ID } } as Browser.Runtime.MessageSender,
            sendResponseMock,
          );
        };
        return () => {
          // noop
        };
      }
    }
    startBackground({
      channel: {
        sendMessage: sendMessageToContent,
        sendNativeMessage: sendMessageToNative,
      },
      messenger: new MockBackgroundMessenger(),
      executeAction: executeAction,
    });
  });

  // TODO: Figure out a way to mock browser.tabs.getCurrent and add test for GetExclusionEntryRequest
  test("GestureChangeMessage", () => {
    const msg: GestureChangeMessage = {
      _tag: "GESTURE_CHANGE",
      gesture: { p: 1 } as unknown as Gesture,
    };
    sendMockMessage(msg);
    expect(sendMessageToContent).toHaveBeenLastCalledWith(1, msg);
  });
  test("GestureReleaseMessage", () => {
    const msg: GestureReleaseMessage = {
      _tag: "GESTURE_RELEASE",
      gesture: { p: 1 } as unknown as Gesture,
    };
    sendMockMessage(msg);
    expect(sendMessageToContent).toHaveBeenLastCalledWith(1, msg);
  });
  test("ExecuteActionMessage", () => {
    const msg: ExecuteActionMessage = {
      _tag: "EXECUTE_ACTION",
      action: "ACTION_OBJ" as unknown as Action,
    };
    sendMockMessage(msg);
    expect(executeAction).toHaveBeenLastCalledWith(
      msg.action,
      expect.anything(),
    );
  });
});
