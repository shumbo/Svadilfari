import { useCallback, useRef } from "react";
import { useEvent } from "react-use";
import { getClosestGestureByPattern } from "../../core/Matching";
import { PatternConstructor } from "../../core/PatternConstructor";
import { Gesture } from "../../SharedTypes";

/**
 * Recognize gestures and send events
 * @param gestures array of gestures to recognize
 * @param onChange called when gesture is recognized
 * @param onRelease called when fingers are released
 */
export function useGestureRecognizer(
  gestures: Gesture[],
  onChange: (gesture: Gesture | null) => void,
  onRelease: (gesture: Gesture | null) => void
): void {
  const patternConstructor = useRef(new PatternConstructor(0.12, 10));

  const getClosestGesture = useCallback(
    () =>
      getClosestGestureByPattern(
        patternConstructor.current.getPattern(),
        new Set(gestures),
        0.15
      ),
    [gestures]
  );

  const touchMoveHandler = useCallback(
    (ev: TouchEvent) => {
      const r = patternConstructor.current.addPoint({
        x: ev.touches[0].clientX,
        y: ev.touches[0].clientY,
      });
      if (r >= 2) {
        onChange(getClosestGesture());
      }
    },
    [onChange, getClosestGesture]
  );

  const touchEndHandler = useCallback(() => {
    const g = getClosestGesture();
    onRelease(g);
    patternConstructor.current.clear();
  }, [onRelease, getClosestGesture]);

  useEvent("touchmove", touchMoveHandler, undefined, { capture: true });
  useEvent("touchend", touchEndHandler, undefined, { capture: true });
}
