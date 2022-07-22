import { FC } from "react";
import { createPortal } from "react-dom";

import { usePortal } from "../../hooks/usePortal";

export type GlobalStylePortalProps = {
  /**
   * Unique ID to the style
   */
  id: string;
  /**
   * CSS to apply to global
   */
  style: string;
};

export const GlobalStylePortal: FC<GlobalStylePortalProps> = ({
  style,
  id,
}) => {
  const target = usePortal("style", `svadilfari-style-${id}`);
  return createPortal(style, target);
};
