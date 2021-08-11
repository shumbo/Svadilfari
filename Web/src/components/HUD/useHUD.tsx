import React, { ReactNode, useState } from "react";
import { HUD, HUDContent, HUDProps } from "./HUD";

export function useHUD(): {
  hud: ReactNode;
  open(content: HUDContent): void;
  cancel(): void;
  resolve(): void;
} {
  const [props, setProps] = useState<HUDProps>({
    title: "",
    visible: false,
    cancel: false,
  });

  const hud = <HUD {...props} />;

  return {
    hud,
    open(content: HUDContent) {
      setProps((props) => ({
        ...props,
        visible: true,
        // reset icon and message as content might not have these keys
        message: undefined,
        icon: undefined,
        ...content,
      }));
    },
    cancel() {
      // FIXME: do this in one function call
      setProps((props) => ({ ...props, cancel: true }));
      setTimeout(() => {
        setProps((props) => ({ ...props, visible: false }));
      }, 0);
    },
    resolve() {
      // FIXME: do this in one function call
      setProps((props) => ({ ...props, cancel: false }));
      setTimeout(() => {
        setProps((props) => ({ ...props, visible: false }));
      }, 0);
    },
  };
}
