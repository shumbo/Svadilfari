import { Action } from "./SharedTypes";

type ActionKey = keyof Action;

export function getActionCode(action: Action): ActionKey | null {
  const key = Object.entries(action).flatMap(([key, value]) =>
    value ? key : [],
  )[0] as ActionKey;
  return key ?? null;
}
