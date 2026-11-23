import React, { FC } from "react";

import styles from "./Switch.module.css";

// The HTML `switch` attribute (Safari 17.4+) renders a native iOS switch.
// Older browsers ignore it and show a regular checkbox.
// https://webkit.org/blog/15054/an-html-switch-control/
declare module "react" {
  interface InputHTMLAttributes<T> {
    switch?: "";
  }
}

export type SwitchProps = {
  checked: boolean;
  disabled?: boolean;
  onChange: (checked: boolean) => void;
  "aria-label"?: string;
  "aria-labelledby"?: string;
  "aria-describedby"?: string;
};

export const Switch: FC<SwitchProps> = ({
  checked,
  disabled,
  onChange,
  ...aria
}) => (
  <input
    type="checkbox"
    switch=""
    className={styles.switch}
    checked={checked}
    disabled={disabled}
    onChange={(event) => onChange(event.target.checked)}
    {...aria}
  />
);
