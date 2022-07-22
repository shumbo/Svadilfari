import React, { Fragment, FC, useId } from "react";
import { animated, useTransition } from "@react-spring/web";

import { GlobalStylePortal } from "../GlobalStylePortal/GlobalStylePortal";

import {
  animationContainerStyle,
  iconWrapperStyle,
  textStyle,
  titleStyle,
  wrapperStyle,
} from "./HUD.css";

export type HUDContent = {
  /**
   * Icon
   * Load svg via svgr and pass the component
   */
  icon?: FC<React.SVGProps<SVGSVGElement>>;
  /**
   * Title
   */
  title: string;
  /**
   * Message
   */
  message?: string;
};

export type HUDProps = {
  className?: string;
  /**
   * Control visibility of the HUD
   */
  visible: boolean;
  /**
   * Change the leave animation
   */
  cancel: boolean;
} & HUDContent;

export const HUD: FC<HUDProps> = ({
  visible,
  icon: Icon,
  title,
  message,
  cancel,
}) => {
  const hudId = useId();
  const transitions = useTransition(visible, {
    from: { opacity: 0, scale: 0.8 },
    enter: { opacity: 1, scale: 1 },
    leave: { opacity: 0, scale: cancel ? 0.8 : 1.2 },
    config: {
      duration: 167,
    },
  });

  return (
    <Fragment>
      {transitions(
        ({ opacity, scale }, item) =>
          item && (
            <animated.div
              className={animationContainerStyle}
              style={{
                opacity,
                scale,
              }}
            >
              <div className={wrapperStyle}>
                {Icon && (
                  <div className={iconWrapperStyle}>
                    <Icon style={{ width: 100, height: 100 }} />
                  </div>
                )}
                <p className={titleStyle}>{title}</p>
                {message && <p className={textStyle}>{message}</p>}
              </div>
            </animated.div>
          )
      )}
      {visible && (
        <GlobalStylePortal
          id={hudId}
          style="* { -webkit-user-select: none; }"
        />
      )}
    </Fragment>
  );
};
HUD.displayName = "HUD";
