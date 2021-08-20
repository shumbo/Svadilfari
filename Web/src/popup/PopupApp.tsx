import { Box } from "@chakra-ui/react";
import React, { Fragment, useEffect, VFC } from "react";
import { useAsyncFn } from "react-use";
import { urlToExclusionListEntry } from "../core/ExclusionList";
import { GetExclusionEntryResponse } from "../SharedTypes";
import { ExceptionToggleGroup } from "./components/ExceptionToggleGroup";
import { StatusAlert } from "./components/StatusAlert";
import { PopupGlobalStyle } from "./PopupGlobalStyle";
import { PopupMessenger } from "./PopupMessenger";
import { PopupTabManager } from "./PopupTabManager";

export type PopupAppProps = {
  messenger: PopupMessenger;
  tabManager: PopupTabManager;
};

function isDomainExcluded(
  entry: GetExclusionEntryResponse["exclusionEntry"] | undefined
): boolean {
  // if exclusion entry exists but it has no path, then the domain is excluded
  return !!entry && !entry.path;
}

function isPageExcluded(
  entry: GetExclusionEntryResponse["exclusionEntry"] | undefined
): boolean {
  // if exclusion entry exists and has a path, then the page is excluded
  return !!entry && !!entry.path;
}

export const PopupApp: VFC<PopupAppProps> = ({ messenger, tabManager }) => {
  const [tabState, updateTabState] = useAsyncFn(async () => {
    const tab = await tabManager.getCurrentTab();
    if (!tab.url) {
      return null;
    }
    const entry = urlToExclusionListEntry(tab.url);
    const exclusionEntry = await messenger.getExclusionEntry(
      entry.domain,
      entry.path
    );
    return {
      tab: {
        domain: entry.domain,
        path: entry.path,
      },
      exclusionEntry: exclusionEntry.exclusionEntry,
    };
  }, []);
  useEffect(() => {
    updateTabState();
  }, [updateTabState]);

  return (
    <Box padding={2}>
      {tabState.value && (
        <Fragment>
          <StatusAlert
            status={tabState.value.exclusionEntry ? "INACTIVE" : "ACTIVE"}
          />
          <ExceptionToggleGroup
            domain={tabState.value.tab.domain}
            path={tabState.value.tab.path}
            value={{
              disabledDomain: isDomainExcluded(tabState.value.exclusionEntry),
              disabledPage: !!tabState.value.exclusionEntry,
            }}
            onChange={(status) => {
              (async () => {
                if (typeof status.disabledDomain === "boolean") {
                  // only process if key is present
                  const currentlyDomainExcluded = isDomainExcluded(
                    tabState.value?.exclusionEntry
                  );
                  // currently disabled on this domain and want to enable by removing the domain exclusion entry
                  if (
                    currentlyDomainExcluded &&
                    !status.disabledDomain &&
                    tabState.value?.exclusionEntry?.id
                  ) {
                    await messenger.removeExclusionEntry(
                      tabState.value.exclusionEntry.id
                    );
                  }
                  // currently enabled on this domain and want to disable by adding a new domain exclusion entry
                  if (
                    !currentlyDomainExcluded &&
                    status.disabledDomain &&
                    tabState.value?.tab
                  ) {
                    await messenger.addExclusionEntry(
                      tabState.value.tab.domain,
                      undefined
                    );
                  }
                }
                if (typeof status.disabledPage === "boolean") {
                  // only process if key is present
                  // only process if key is present
                  const currentlyPageExcluded = isPageExcluded(
                    tabState.value?.exclusionEntry
                  );
                  // currently disabled on this page and want to enable by removing the page exclusion entry
                  if (
                    currentlyPageExcluded &&
                    !status.disabledPage &&
                    tabState.value?.exclusionEntry?.id
                  ) {
                    await messenger.removeExclusionEntry(
                      tabState.value.exclusionEntry.id
                    );
                  }
                  // currently enabled on this page and want to disable by adding a new page exclusion entry
                  if (
                    !currentlyPageExcluded &&
                    status.disabledPage &&
                    tabState.value?.tab
                  ) {
                    await messenger.addExclusionEntry(
                      tabState.value.tab.domain,
                      tabState.value.tab.path
                    );
                  }
                }
                await updateTabState();
              })().catch((error) => {
                // TODO: Error handling
                console.error(error);
              });
            }}
          />
        </Fragment>
      )}
      <PopupGlobalStyle />
    </Box>
  );
};
