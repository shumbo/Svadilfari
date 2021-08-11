export type NativeProxyMessage = {
  type: "NATIVE_PROXY";
  payload: unknown;
};

export type InternalMessage = NativeProxyMessage;
