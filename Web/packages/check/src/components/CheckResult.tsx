import React, { FC, ReactNode } from "react";
import { t } from "react-i18nify";

import { ActivityIndicator } from "./ActivityIndicator";
import styles from "./CheckResult.module.css";

export type CheckResultProps = {
  status: "ACTIVE" | "INACTIVE" | "UNSUPPORTED" | null;
  onOpenApp: () => void;
};

type Tone = "success" | "warning" | "error";

const CheckmarkCircleFill: FC = () => (
  <svg viewBox="0 0 24 24" aria-hidden="true">
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

const ExclamationTriangleFill: FC = () => (
  <svg viewBox="0 0 24 24" aria-hidden="true">
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

const XmarkCircleFill: FC = () => (
  <svg viewBox="0 0 24 24" aria-hidden="true">
    <circle cx="12" cy="12" r="11" fill="currentColor" />
    <path
      d="M8.5 8.5l7 7M15.5 8.5l-7 7"
      stroke="#fff"
      strokeWidth="2.2"
      strokeLinecap="round"
    />
  </svg>
);

const icons: Record<Tone, FC> = {
  success: CheckmarkCircleFill,
  warning: ExclamationTriangleFill,
  error: XmarkCircleFill,
};

const Result: FC<{
  tone: Tone;
  title: string;
  description: string;
  children?: ReactNode;
}> = ({ tone, title, description, children }) => {
  const Icon = icons[tone];
  return (
    <div role="status" className={`${styles.screen} ${styles[tone]}`}>
      <div className={styles.icon}>
        <Icon />
      </div>
      <h1 className={styles.title}>{title}</h1>
      <p className={styles.description}>{description}</p>
      {children}
    </div>
  );
};

export const CheckResult: FC<CheckResultProps> = ({ status, onOpenApp }) => {
  if (status === null) {
    const label = t("check_result.check_in_progress");
    return (
      <div className={styles.screen}>
        <ActivityIndicator label={label} />
        <p className={styles.description}>{label}</p>
      </div>
    );
  }
  if (status === "ACTIVE") {
    return (
      <Result
        tone="success"
        title={t("check_result.active.title")}
        description={t("check_result.active.description")}
      >
        <button
          type="button"
          className={styles.filledButton}
          onClick={onOpenApp}
        >
          {t("check_result.app_link")}
        </button>
      </Result>
    );
  }
  if (status === "UNSUPPORTED") {
    return (
      <Result
        tone="error"
        title={t("check_result.unsupported.title")}
        description={t("check_result.unsupported.description")}
      />
    );
  }
  return (
    <Result
      tone="warning"
      title={t("check_result.inactive.title")}
      description={t("check_result.inactive.description")}
    >
      <button type="button" className={styles.filledButton} onClick={onOpenApp}>
        {t("check_result.app_link")}
      </button>
      <p className={styles.footnote}>
        {t("check_result.inactive.still_having_problem")}
      </p>
      <a
        className={styles.plainButton}
        href="https://rebrand.ly/svadilfari-contact"
      >
        {t("check_result.inactive.contact_us")}
      </a>
    </Result>
  );
};
