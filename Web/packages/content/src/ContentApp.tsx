import { ContentMessenger, urlToExclusionListEntry, Gesture } from "core";
import React, { Fragment, useCallback, useEffect, useMemo, VFC } from "react";
import { useAsync, useAsyncFn } from "react-use";
import { unreachableCase } from "ts-assert-unreachable";
import { Browser } from "webextension-typedef";
import { useHUD } from "./components/HUD/useHUD";
import { useGestureRecognizer } from "./hooks/useGestureRecognizer";
import { getActionHUDContent } from "./utils/getActionHUDContent";
import { isEmbededFrame } from "./utils/isEmbedFrame";

export type ContentAppProps = {
  messenger: ContentMessenger;
  i18n: Browser.I18n.Static;
};

export const ContentApp: VFC<ContentAppProps> = ({ messenger, i18n }) => {
  const { hud, open, cancel, resolve } = useHUD();
  const { value: gestureResponse } = useAsync(messenger.getGesture, [
    messenger,
  ]);
  const [
    { value: exclusionEntry, loading: exclusionEntryLoading },
    fetchExclusionEntry,
  ] = useAsyncFn(async () => {
    const response = await messenger.getCurrentTabExclusionEntry();
    return response.exclusionEntry;
  }, [messenger]);
  useEffect(() => {
    fetchExclusionEntry();
  }, [fetchExclusionEntry]);

  const enabledGestures = useMemo(() => {
    if (exclusionEntryLoading || (!exclusionEntryLoading && !!exclusionEntry)) {
      return [];
    }
    const egs = gestureResponse?.gestures?.filter((g) => g.enabled) ?? [];
    return egs;
  }, [gestureResponse?.gestures, exclusionEntry, exclusionEntryLoading]);

  const applyOnChangeToHUD = useCallback(
    (g: Gesture | null) => {
      if (g) {
        open(getActionHUDContent(g.action, i18n));
      } else {
        cancel();
      }
    },
    [cancel, open, i18n]
  );

  const onChangeHandler = useCallback(
    (g: Gesture | null) => {
      if (isEmbededFrame()) {
        messenger.gestureChange(g);
      } else {
        applyOnChangeToHUD(g);
      }
    },
    [applyOnChangeToHUD, messenger]
  );

  const applyOnReleaseToHUD = useCallback(
    (g: Gesture | null) => {
      if (g) {
        resolve();
        setTimeout(() => {
          messenger.executeAction(g.action);
        }, 200);
      } else {
        cancel();
      }
    },
    [cancel, messenger, resolve]
  );

  const onReleaseHandler = useCallback(
    (g: Gesture | null) => {
      if (isEmbededFrame()) {
        messenger.gestureRelease(g);
        return;
      }
      applyOnReleaseToHUD(g);
    },
    [applyOnReleaseToHUD, messenger]
  );

  useEffect(() => {
    const unsubscribe = messenger.onMessage((msg) => {
      switch (msg._tag) {
        case "APPLY_EXCLUSION_ENTRY": {
          fetchExclusionEntry();
          break;
        }
        case "GESTURE_CHANGE": {
          if (isEmbededFrame()) {
            break;
          }
          applyOnChangeToHUD(msg.gesture);
          break;
        }
        case "GESTURE_RELEASE": {
          if (isEmbededFrame()) {
            break;
          }
          applyOnReleaseToHUD(msg.gesture);
          break;
        }
        default:
          unreachableCase(msg);
      }
    });
    return () => {
      unsubscribe();
    };
  }, [applyOnChangeToHUD, applyOnReleaseToHUD, fetchExclusionEntry, messenger]);

  useGestureRecognizer(
    enabledGestures ?? [],
    // onChange
    onChangeHandler,
    // onRelease
    onReleaseHandler
  );
  return <Fragment>{hud}</Fragment>;
};
