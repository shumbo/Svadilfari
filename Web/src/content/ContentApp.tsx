import React, { Fragment, useCallback, useEffect, useMemo, VFC } from "react";
import { useAsync, useAsyncFn } from "react-use";
import { I18n } from "webextension-polyfill/namespaces/i18n";
import { useHUD } from "../components/HUD/useHUD";
import { ContentMessanger } from "../messenger/ContentMessanger";
import { Gesture } from "../SharedTypes";
import { useGestureRecognizer } from "./hooks/useGestureRecognizer";
import { getActionHUDContent } from "./utils/getActionHUDContent";
import { isEmbededFrame } from "./utils/isEmbedFrame";

export type ContentAppProps = {
  messenger: ContentMessanger;
  i18n: I18n.Static;
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
    const response = await messenger.getExclusionEntry();
    return response.exclusionEntry;
  }, [messenger]);
  useEffect(() => {
    fetchExclusionEntry();
  }, [fetchExclusionEntry]);

  const enabledGestures = useMemo(() => {
    if (exclusionEntryLoading || (!exclusionEntryLoading && !!exclusionEntry)) {
      return [];
    }
    return gestureResponse?.gestures?.filter((g) => g.enabled) ?? [];
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
        messenger.forwardGestureChange(g);
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
        messenger.forwardGestureRelease(g);
        return;
      }
      applyOnReleaseToHUD(g);
    },
    [applyOnReleaseToHUD, messenger]
  );

  useEffect(() => {
    const s = messenger.onGestureChange(applyOnChangeToHUD);
    const t = messenger.onGestureRelease(applyOnReleaseToHUD);
    const u = messenger.onUpdateExclusionEntry(() => {
      fetchExclusionEntry();
    });
    return () => {
      s();
      t();
      u();
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
