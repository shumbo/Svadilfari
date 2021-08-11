import React, { useEffect, VFC } from "react";
import { useAsync } from "react-use";
import { useHUD } from "../components/HUD/useHUD";
import { ContentMessanger } from "../messenger/ContentMessanger";
import { useGestureRecognizer } from "./hooks/useGestureRecognizer";
import { getActionHUDContent } from "./utils/getActionHUDContent";

export type ContentAppProps = {
  contentMessenger: ContentMessanger;
};

export const ContentApp: VFC<ContentAppProps> = ({ contentMessenger }) => {
  const { hud, open, cancel, resolve } = useHUD();
  const { value: gestureResponse } = useAsync(contentMessenger.getGesture, [
    contentMessenger,
  ]);
  useGestureRecognizer(
    gestureResponse?.gestures ?? [],
    // onChange
    (g) => {
      if (g) {
        open(getActionHUDContent(g.action));
      } else {
        cancel();
      }
    },
    // onRelease
    (g) => {
      if (g) {
        resolve();
        contentMessenger.executeAction(g.action);
      } else {
        cancel();
      }
    }
  );
  return <div>{hud}</div>;
};
