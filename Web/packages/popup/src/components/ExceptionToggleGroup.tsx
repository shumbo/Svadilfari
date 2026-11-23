import React, { useMemo, FC, useId } from "react";
import { Browser } from "webextension-typedef";

import { ExceptionToggle } from "./ExceptionToggle";
import styles from "./ExceptionToggleGroup.module.css";

export type ExceptionStatus = {
  /**
   * true if Svadilfari is disabled on this domain
   */
  disabledDomain: boolean;
  /**
   * true if Svadilfari is disabled on this page
   */
  disabledPage: boolean;
};

export type ExceptionToggleGroupProps = {
  i18n: Browser.I18n.Static;
  domain: string;
  path: string;
  value: ExceptionStatus;
  onChange: (newValue: Partial<ExceptionStatus>) => void;
};

export const ExceptionToggleGroup: FC<ExceptionToggleGroupProps> = ({
  i18n,
  domain,
  path,
  value,
  onChange,
}) => {
  const headerId = useId();
  const header = useMemo(
    () => i18n.getMessage("exception_toggle_group:disable_gestures_on"),
    [i18n],
  );
  const domainTitle = useMemo(
    () => i18n.getMessage("exception_toggle_group:this_domain"),
    [i18n],
  );
  const pageTitle = useMemo(
    () => i18n.getMessage("exception_toggle_group:this_page"),
    [i18n],
  );
  return (
    <section className={styles.section} aria-labelledby={headerId}>
      <h2 id={headerId} className={styles.header}>
        {header}
      </h2>
      <div className={styles.group}>
        <ExceptionToggle
          title={domainTitle}
          description={domain}
          onChange={(b) => {
            onChange({ disabledDomain: b });
          }}
          value={value.disabledDomain}
        />
        <div className={styles.nested}>
          <ExceptionToggle
            title={pageTitle}
            description={path}
            isDisabled={value.disabledDomain}
            onChange={(b) => {
              onChange({ disabledPage: b });
            }}
            value={value.disabledPage}
          />
        </div>
      </div>
    </section>
  );
};
