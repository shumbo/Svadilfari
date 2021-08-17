import React, { Fragment, useEffect, useMemo, VFC } from "react";
import { useAsyncFn } from "react-use";
import {
  addToExclusionList,
  isExcluded,
  removeFromExclusionList,
  urlToExclusionListEntry,
} from "../core/ExclusionList";
import { ExceptionToggleGroup } from "./components/ExceptionToggleGroup";
import { StatusAlert } from "./components/StatusAlert";
import { PopupGlobalStyle } from "./PopupGlobalStyle";
import { PopupMessenger } from "./PopupMessenger";
import { PopupTabManager } from "./PopupTabManager";

export type PopupAppProps = {
  messenger: PopupMessenger;
  tabManager: PopupTabManager;
};

export const PopupApp: VFC<PopupAppProps> = ({ messenger, tabManager }) => {
  const [tabState, loadTabState] = useAsyncFn(() => tabManager.getCurrentTab());
  const [settingsState, loadSettingsState] = useAsyncFn(() =>
    messenger.loadSettings()
  );

  // load state on mount
  useEffect(() => {
    loadTabState();
    loadSettingsState();
  }, [loadSettingsState, loadTabState]);

  const currentTabExclusionEntry = useMemo(() => {
    if (!tabState.value?.url) {
      return null;
    }
    return urlToExclusionListEntry(tabState.value.url);
  }, [tabState.value]);

  const [, updateExclusionList] = useAsyncFn(
    (exclusionList: string[]) => messenger.updateExclusionList(exclusionList),
    []
  );

  return (
    <Fragment>
      {currentTabExclusionEntry && settingsState.value?.exclusionList && (
        <Fragment>
          <StatusAlert
            status={
              isExcluded(
                settingsState.value.exclusionList,
                currentTabExclusionEntry.page
              )
                ? "INACTIVE"
                : "ACTIVE"
            }
          />
          <ExceptionToggleGroup
            domain={currentTabExclusionEntry.domain}
            path={currentTabExclusionEntry.path}
            value={{
              disabledDomain: isExcluded(
                settingsState.value.exclusionList,
                currentTabExclusionEntry.domain
              ),
              disabledPage: isExcluded(
                settingsState.value.exclusionList,
                currentTabExclusionEntry.page
              ),
            }}
            onChange={(status) => {
              const currentExclusionList = settingsState.value?.exclusionList;
              if (!currentExclusionList) {
                return;
              }
              let newExclusionList: string[] | null = null;
              if (typeof status.disabledDomain === "boolean") {
                // only process if key is present
                if (status.disabledDomain) {
                  // add domain entry (and remove page entries with the same domain)
                  newExclusionList = addToExclusionList(
                    currentExclusionList,
                    currentTabExclusionEntry.domain
                  );
                } else {
                  // remove domain entry
                  newExclusionList = removeFromExclusionList(
                    currentExclusionList,
                    currentTabExclusionEntry.domain
                  );
                }
              }
              if (typeof status.disabledPage === "boolean") {
                if (status.disabledPage) {
                  newExclusionList = addToExclusionList(
                    currentExclusionList,
                    currentTabExclusionEntry.page
                  );
                } else {
                  newExclusionList = removeFromExclusionList(
                    currentExclusionList,
                    currentTabExclusionEntry.page
                  );
                }
              }
              if (newExclusionList) {
                updateExclusionList(newExclusionList).then(() => {
                  loadSettingsState();
                });
              }
            }}
          />
        </Fragment>
      )}
      <PopupGlobalStyle />
    </Fragment>
  );
};
