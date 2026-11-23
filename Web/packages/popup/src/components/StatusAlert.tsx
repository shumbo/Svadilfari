import React, { useMemo, FC } from "react";
import { Browser } from "webextension-typedef";

import styles from "./StatusAlert.module.css";

export type StatusAlertProps = {
  i18n: Browser.I18n.Static;
  status: "ACTIVE" | "INACTIVE" | null;
};

/** SF Symbol "checkmark.circle.fill" */
const CheckmarkCircleFill: FC = () => (
  <svg viewBox="0 0 24 24" aria-hidden="true" className={styles.icon}>
    <circle cx="12" cy="12" r="11" fill="currentColor" />
    <path
      d="M7 12.5l3.2 3.2L17 9"
      fill="none"
      stroke="#fff"
      strokeWidth="2.2"
      strokeLinecap="round"
      strokeLinejoin="round"
    />
  </svg>
);

/** SF Symbol "exclamationmark.triangle.fill" */
const ExclamationTriangleFill: FC = () => (
  <svg viewBox="0 0 24 24" aria-hidden="true" className={styles.icon}>
    <path
      d="M10.27 3.2a2 2 0 0 1 3.46 0l8.5 14.72A2 2 0 0 1 20.5 21h-17a2 2 0 0 1-1.73-3.08z"
      fill="currentColor"
    />
    <path
      d="M12 8.5v5.2"
      stroke="#fff"
      strokeWidth="2.2"
      strokeLinecap="round"
    />
    <circle cx="12" cy="17.2" r="1.3" fill="#fff" />
  </svg>
);

export const StatusAlert: FC<StatusAlertProps> = ({ i18n, status }) => {
  const activeMsg = useMemo(
    () => i18n.getMessage("status_alert:active"),
    [i18n],
  );
  const inactiveMsg = useMemo(
    () => i18n.getMessage("status_alert:inactive"),
    [i18n],
  );
  if (status === null) {
    return null;
  }
  const active = status === "ACTIVE";
  return (
    <div
      role="status"
      className={`${styles.alert} ${active ? styles.active : styles.inactive}`}
    >
      {active ? <CheckmarkCircleFill /> : <ExclamationTriangleFill />}
      <p className={styles.message}>{active ? activeMsg : inactiveMsg}</p>
    </div>
  );
};
