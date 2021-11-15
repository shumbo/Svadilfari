import { useEffect, useState, useMemo } from "react";

export function useChecker(
  check: () => boolean,
  checkBrowser: () => boolean
): "ACTIVE" | "INACTIVE" | "UNSUPPORTED" | null {
  const [enabled, setEnabled] = useState<boolean | null>(null);
  useEffect(() => {
    let subscribed = true;

    function aux(remainingAttempt: number) {
      if (!subscribed) {
        return;
      }
      if (remainingAttempt === 0) {
        setEnabled(false);
        return;
      }
      if (check()) {
        setEnabled(true);
        return;
      }
      setTimeout(() => {
        aux(remainingAttempt - 1);
      }, 1000);
    }
    aux(5);

    return () => {
      subscribed = false;
    };
  }, [check]);

  const isSupported = useMemo(() => {
    return checkBrowser();
  }, [checkBrowser]);
  console.log({ isSupported });
  if (!isSupported) {
    return "UNSUPPORTED";
  }

  if (enabled === null) {
    return null;
  }
  return enabled ? "ACTIVE" : "INACTIVE";
}
