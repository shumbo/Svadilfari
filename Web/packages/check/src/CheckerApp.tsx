import React, { FC } from "react";

import { CheckResult } from "./components/CheckResult";
import { useChecker } from "./hooks/useChecker";

export type CheckerAppProps = {
  check: () => boolean;
  checkBrowser: () => boolean;
  onOpenApp: () => void;
};

export const CheckerApp: FC<CheckerAppProps> = ({
  check,
  checkBrowser,
  onOpenApp,
}) => {
  const status = useChecker(check, checkBrowser);
  return <CheckResult status={status} onOpenApp={onOpenApp} />;
};
