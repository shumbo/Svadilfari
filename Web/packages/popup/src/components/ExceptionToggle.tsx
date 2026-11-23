import React, { FC, useId } from "react";

import { Switch } from "./Switch";
import styles from "./ExceptionToggle.module.css";

export type ExceptionToggleProps = {
  title: string;
  description: string;
  value: boolean;
  isDisabled?: boolean;
  onChange: (newValue: boolean) => void;
};

export const ExceptionToggle: FC<ExceptionToggleProps> = ({
  title,
  description,
  value,
  isDisabled,
  onChange,
}) => {
  const id = useId();
  return (
    <div className={`${styles.row} ${isDisabled ? styles.disabled : ""}`}>
      <div className={styles.text}>
        <span id={`${id}-title`} className={styles.title}>
          {title}
        </span>
        <span
          id={`${id}-description`}
          className={styles.description}
          title={description}
        >
          {description}
        </span>
      </div>
      <Switch
        checked={value}
        disabled={isDisabled}
        onChange={onChange}
        aria-labelledby={`${id}-title`}
        aria-describedby={`${id}-description`}
      />
    </div>
  );
};
