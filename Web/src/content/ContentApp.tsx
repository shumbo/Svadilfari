import React, { useState, VFC } from "react";
import { HUD } from "../components/HUD/HUD";
import root from "react-shadow/emotion";
import { useHUD } from "../components/HUD/useHUD";

(window as any).global = window;

export const ContentApp: VFC = () => {
  const [visible, setVisible] = useState(false);
  const {} = useHUD();
  return (
    <root.div>
      <HUD visible={visible} title="hi" cancel={false} />
      <button
        onClick={() => {
          setVisible(true);
          setTimeout(() => {
            setVisible(false);
          }, 2000);
        }}
      >
        Show HUD
      </button>
    </root.div>
  );
};
