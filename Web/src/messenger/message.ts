import { Action } from "../SharedTypes";

/**
 * Forward the payload to the native extension
 */
export type NativeProxyMessage = {
  type: "NATIVE_PROXY";
  payload: unknown;
};

/**
 * Forward the payload to the top frame
 */
export type TopFrameProxyMessage = {
  type: "TOP_FRAME_PROXY";
  payload: unknown;
};

/**
 * Tell the background page to execute the action
 */
export type ExecuteActionMessage = {
  type: "EXECUTE_ACTION";
  action: Action;
};

export type InternalMessage =
  | NativeProxyMessage
  | TopFrameProxyMessage
  | ExecuteActionMessage;
