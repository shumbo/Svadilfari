import { Browser } from "webextension-typedef";

import {
  Action,
  AddExclusionEntryRequest,
  Gesture,
  GetExclusionEntryRequest,
  GetExclusionEntryResponse,
  GetGestureResponse,
  RemoveExclusionEntryRequest,
} from "./SharedTypes";

/**
 * Message types are only used by browser extension components (Popup, Content and Background)
 * Background is in charge of converting these messages into
 */

type Base<T extends string, S = unknown> = {
  /**
   * Internal tag for message distinction
   * Have no meaning on Swift
   */
  _tag: T;
} & S;

/**
 * Get a list of configured gestures
 * Content -> Background -> Native
 */
export type GetGestureRequestMessage = Base<"GET_GESTURE_REQUEST">;

/**
 * Add an exclusion entry
 * Popup -> Background -> Native
 */
export type AddExclusionEntryRequestMessage = Base<
  "ADD_EXCLUSION_ENTRY_REQUEST",
  AddExclusionEntryRequest
>;

/**
 * Remove an exclusion entry
 * Popup -> Background -> Native
 */
export type RemoveExclusionEntryRequestMessage = Base<
  "REMOVE_EXCLUSION_ENTRY_REQUEST",
  RemoveExclusionEntryRequest
>;

/**
 * Get the exclusion entry
 * Returns null if the entry is not found
 * Popup -> Background -> Native
 */
export type GetExclusionEntryRequestMessage = Base<
  "GET_EXCLUSION_ENTRY_REQUEST",
  { domain: string; path: string }
>;

/**
 * Get the exclusion entry for the current tab
 * Background will use the information of sender to determine the domain and path
 * Returns null if the entry is not found
 * Content -> Background -> Native
 */
export type GetCurrentTabExclusionEntryRequestMessage =
  Base<"GET_CURRENT_TAB_EXCLUSION_ENTRY_REQUEST">;

/**
 * Preview gesture
 * Content (Subframe) -> Background -> Content (Top Frame)
 */
export type GestureChangeMessage = Base<
  "GESTURE_CHANGE",
  { gesture: Gesture | null }
>;

/**
 * End preview gesture
 * Content (Subframe) -> Background -> Content (Top Frame)
 */
export type GestureReleaseMessage = Base<
  "GESTURE_RELEASE",
  { gesture: Gesture | null }
>;

/**
 * Apply changes made in exclusion list
 * Popup -> Background -> Content
 */
export type ApplyExclusionEntryMessage = Base<"APPLY_EXCLUSION_ENTRY">;

/**
 * Execute the recognized action
 * Content -> Background
 */
export type ExecuteActionMessage = Base<
  "EXECUTE_ACTION",
  {
    action: Action;
  }
>;

/**
 * Interface for ContentMessanger
 */
export interface ContentMessenger {
  /**
   * Get configured gestures
   */
  getGesture(): Promise<GetGestureResponse>;
  /**
   * Get the exclusion entry of current page, if any
   */
  getCurrentTabExclusionEntry(): Promise<GetExclusionEntryResponse>;
  /**
   * Notify the top frame the change in gesture
   * @param gesture Gesture to preview, or null to hide preview
   */
  gestureChange(gesture: Gesture | null): Promise<void>;
  /**
   * Notify the top frame the release of gesture
   * @param gesture Gesture to execute, or null to do nothing
   */
  gestureRelease(gesture: Gesture | null): Promise<void>;
  /**
   * Notify the background page to execute the selected action
   * @param action
   */
  executeAction(action: Action): Promise<void>;
  /**
   * Set up a handler function that is called when the content receives message
   * @param handler a function that handles incoming messages
   * @returns clojure that unsubscribes events
   */
  onMessage(
    handler: (
      message:
        | GestureChangeMessage
        | GestureReleaseMessage
        | ApplyExclusionEntryMessage,
    ) => void,
  ): () => void;
}

/**
 * Interface for PopupMessenger
 */
export interface PopupMessenger {
  /**
   * Add new exclusion list entry
   * @param req domain and path (optional)
   */
  addExclusionEntry(req: AddExclusionEntryRequest): Promise<void>;
  /**
   * Remove an exclusion list entry
   * @param uuid uuid
   */
  removeExclusionEntry(uuid: string): Promise<void>;
  /**
   * Get the exclusion entry of current page, if any
   */
  getExclusionEntry(
    req: GetExclusionEntryRequest,
  ): Promise<GetExclusionEntryResponse>;
  /**
   * Apply the updated exclusion entry to content
   */
  applyExclusionEntry(): Promise<void>;
}

export interface BackgroundMessenger {
  /**
   * register a handler that is called on receiving messages
   * @param handler handler
   */
  onMessage(
    handler: (
      msg:
        | GetGestureRequestMessage
        | AddExclusionEntryRequestMessage
        | RemoveExclusionEntryRequestMessage
        | GetExclusionEntryRequestMessage
        | GetCurrentTabExclusionEntryRequestMessage
        | GestureChangeMessage
        | GestureReleaseMessage
        | ExecuteActionMessage,
      sender: Browser.Runtime.MessageSender,
      sendResponse: (...response: any[]) => void, // eslint-disable-line
    ) => void,
  ): () => void;
}
