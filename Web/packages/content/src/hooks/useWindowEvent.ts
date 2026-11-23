import { useEffect } from "react";

export function useWindowEvent<K extends keyof WindowEventMap>(
  type: K,
  handler: (event: WindowEventMap[K]) => void,
  options?: AddEventListenerOptions,
): void {
  const capture = options?.capture;
  const passive = options?.passive;
  useEffect(() => {
    const opts = { capture, passive };
    window.addEventListener(type, handler, opts);
    return () => {
      window.removeEventListener(type, handler, opts);
    };
  }, [type, handler, capture, passive]);
}
