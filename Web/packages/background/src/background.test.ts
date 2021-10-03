/* eslint-disable @typescript-eslint/no-explicit-any */
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

const TAB_ID = 1;

describe("Background", () => {
  let sendMockMessage: (msg: any) => void;
  let sendResponseMock: jest.Mock;
  let sendMessageToContent: jest.Mock;
  let sendMessageToNative: jest.Mock;
  let executeAction: jest.Mock;
  beforeEach(() => {
    sendResponseMock = jest.fn();
    sendMessageToContent = jest.fn();
    sendMessageToNative = jest.fn();
    executeAction = jest.fn().mockImplementation(() => Promise.resolve());
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
          sendResponse: (...response: any[]) => void
        ) => void
      ): () => void {
        sendMockMessage = (msg) =>
          handler(
            msg,
            { tab: { id: TAB_ID } } as Browser.Runtime.MessageSender,
            sendResponseMock
          );
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
  test("GetGestureRequest", () => {
    const msg: GetGestureRequestMessage = { _tag: "GET_GESTURE_REQUEST" };
    sendMockMessage(msg);
    expect(sendMessageToNative).toHaveBeenLastCalledWith(
      Convert.messageRequestToJson({ getGestures: true })
    );
  });
  test("AddExclusionEntryRequest", () => {
    const msg: AddExclusionEntryRequestMessage = {
      _tag: "ADD_EXCLUSION_ENTRY_REQUEST",
      domain: "example.com",
    };
    sendMockMessage(msg);
    expect(sendMessageToNative).toHaveBeenLastCalledWith(
      Convert.messageRequestToJson({
        addExclusionEntry: { domain: "example.com" },
      })
    );
  });
  test("RemoveExclusionEntryRequest", () => {
    const msg: RemoveExclusionEntryRequestMessage = {
      _tag: "REMOVE_EXCLUSION_ENTRY_REQUEST",
      id: "entry-id",
    };
    sendMockMessage(msg);
    expect(sendMessageToNative).toHaveBeenLastCalledWith(
      Convert.messageRequestToJson({
        removeExclusionEntry: { id: "entry-id" },
      })
    );
  });
  // TODO: Figure out a way to mock browser.tabs.getCurrent and add test for GetExclusionEntryRequest
  test("GestureChangeMessage", () => {
    const msg: GestureChangeMessage = {
      _tag: "GESTURE_CHANGE",
      gesture: ({ p: 1 } as unknown) as Gesture,
    };
    sendMockMessage(msg);
    expect(sendMessageToContent).toHaveBeenLastCalledWith(1, msg);
  });
  test("GestureReleaseMessage", () => {
    const msg: GestureReleaseMessage = {
      _tag: "GESTURE_RELEASE",
      gesture: ({ p: 1 } as unknown) as Gesture,
    };
    sendMockMessage(msg);
    expect(sendMessageToContent).toHaveBeenLastCalledWith(1, msg);
  });
  test("ExecuteActionMessage", () => {
    const msg: ExecuteActionMessage = {
      _tag: "EXECUTE_ACTION",
      action: ("ACTION_OBJ" as unknown) as Action,
    };
    sendMockMessage(msg);
    expect(executeAction).toHaveBeenLastCalledWith(
      msg.action,
      expect.anything()
    );
  });
});
