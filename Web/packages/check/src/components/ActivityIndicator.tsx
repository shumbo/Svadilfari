import React, { FC } from "react";

import styles from "./ActivityIndicator.module.css";

const SPOKES = 8;

export const ActivityIndicator: FC<{ label: string }> = ({ label }) => (
  <span role="progressbar" aria-label={label} className={styles.indicator}>
    {Array.from({ length: SPOKES }, (_, i) => (
      <span
        key={i}
        className={styles.spoke}
        style={{
          transform: `rotate(${(360 / SPOKES) * i}deg)`,
          animationDelay: `${(-1 / SPOKES) * (SPOKES - i)}s`,
        }}
      />
    ))}
  </span>
);
