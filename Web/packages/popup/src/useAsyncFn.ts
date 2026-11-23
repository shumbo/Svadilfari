import {
  DependencyList,
  useCallback,
  useEffect,
  useRef,
  useState,
} from "react";

export type AsyncState<T> = {
  loading: boolean;
  value?: T;
  error?: unknown;
};

export function useAsyncFn<T>(
  fn: () => Promise<T>,
  deps: DependencyList,
  initialState: AsyncState<T> = { loading: false },
): [AsyncState<T>, () => Promise<T | undefined>] {
  const [state, setState] = useState<AsyncState<T>>(initialState);
  const lastCallId = useRef(0);
  const mounted = useRef(false);
  useEffect(() => {
    mounted.current = true;
    return () => {
      mounted.current = false;
    };
  }, []);

  const callback = useCallback(async () => {
    const callId = ++lastCallId.current;
    setState((prev) => (prev.loading ? prev : { ...prev, loading: true }));
    const isLatest = () => mounted.current && callId === lastCallId.current;
    try {
      const value = await fn();
      if (isLatest()) setState({ loading: false, value });
      return value;
    } catch (error) {
      if (isLatest()) setState({ loading: false, error });
      return undefined;
    }
    // oxlint-disable-next-line react-hooks/exhaustive-deps
  }, deps);

  return [state, callback];
}

export function useAsync<T>(
  fn: () => Promise<T>,
  deps: DependencyList,
): AsyncState<T> {
  const [state, callback] = useAsyncFn(fn, deps, { loading: true });
  useEffect(() => {
    void callback();
  }, [callback]);
  return state;
}
