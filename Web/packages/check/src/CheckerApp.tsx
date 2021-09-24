import React, { VFC } from "react";
import { CheckResult } from "./components/CheckResult";
import { useChecker } from "./hooks/useChecker";

export type CheckerAppProps = {
  check: () => boolean;
  onOpenApp: () => void;
};

export const CheckerApp: VFC<CheckerAppProps> = ({ check, onOpenApp }) => {
  const status = useChecker(check);
  return <CheckResult status={status} onOpenApp={onOpenApp} />;
};
