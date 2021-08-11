import React, { Fragment, useCallback, useEffect, VFC } from "react";
import { useAsync } from "react-use";
import { useHUD } from "../components/HUD/useHUD";
import { ContentMessanger } from "../messenger/ContentMessanger";
import { Gesture } from "../SharedTypes";
import { useGestureRecognizer } from "./hooks/useGestureRecognizer";
import { getActionHUDContent } from "./utils/getActionHUDContent";
import { isEmbededFrame } from "./utils/isEmbedFrame";

export type ContentAppProps = {
  contentMessenger: ContentMessanger;
};

export const ContentApp: VFC<ContentAppProps> = ({ contentMessenger }) => {
  const { hud, open, cancel, resolve } = useHUD();
  const { value: gestureResponse } = useAsync(contentMessenger.getGesture, [
    contentMessenger,
  ]);

  const applyOnChangeToHUD = useCallback(
    (g: Gesture | null) => {
      if (g) {
        open(getActionHUDContent(g.action));
      } else {
        cancel();
      }
    },
    [cancel, open]
  );

  const onChangeHandler = useCallback(
    (g: Gesture | null) => {
      if (isEmbededFrame()) {
        contentMessenger.forwardGestureChange(g);
      } else {
        applyOnChangeToHUD(g);
      }
    },
    [applyOnChangeToHUD, contentMessenger]
  );

  const applyOnReleaseToHUD = useCallback(
    (g: Gesture | null) => {
      if (g) {
        resolve();
        contentMessenger.executeAction(g.action);
      } else {
        cancel();
      }
    },
    [cancel, contentMessenger, resolve]
  );

  const onReleaseHandler = useCallback(
    (g: Gesture | null) => {
      if (isEmbededFrame()) {
        contentMessenger.forwardGestureRelease(g);
        return;
      }
      applyOnReleaseToHUD(g);
    },
    [applyOnReleaseToHUD, contentMessenger]
  );

  useEffect(() => {
    const s = contentMessenger.onGestureChange(applyOnChangeToHUD);
    const t = contentMessenger.onGestureRelease(applyOnReleaseToHUD);
    return () => {
      s();
      t();
    };
  }, [applyOnChangeToHUD, applyOnReleaseToHUD, contentMessenger]);

  useGestureRecognizer(
    gestureResponse?.gestures ?? [],
    // onChange
    onChangeHandler,
    // onRelease
    onReleaseHandler
  );
  return <Fragment>{hud}</Fragment>;
};
