import React, { useState } from "react";
import ReactDOM from "react-dom";
import { HUD, HUDProps } from "./HUD";

type HUDContent = Pick<HUDProps, "icon" | "title" | "message">;

export function useHUD() {
  const [props, setProps] = useState<HUDProps>({
    title: "",
    visible: false,
    cancel: false,
  });

  const hud = <HUD {...props} />;

  return {
    hud,
    open(content: HUDContent) {
      setProps((props) => ({ ...props, visible: true, ...content }));
    },
    cancel() {
      setProps((props) => ({ ...props, cancel: true, visible: false }));
    },
    resolve() {
      setProps((props) => ({ ...props, cancel: false, visible: false }));
    },
  };
}
