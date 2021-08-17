/**
 * Check if the entry is in the exclusion list
 * @param exclusionList
 * @param entry domain or domain + path
 */
export function isExcluded(exclusionList: string[], entry: string): boolean {
  for (const item of exclusionList) {
    if (isPageEntry(item)) {
      if (item === entry) {
        return true;
      }
    } else {
      const domain = getDomain(entry);
      if (item === domain) {
        return true;
      }
    }
  }
  return false;
}

export function addToExclusionList(
  exclusionList: string[],
  entry: string
): string[] {
  let result = [...exclusionList];
  if (!isPageEntry(entry)) {
    // if domain entry, remove all page entries with the domain
    result = result.filter((item) => getDomain(item) !== entry);
  }
  result.push(entry);
  return result;
}

export function removeFromExclusionList(
  exclusionList: string[],
  entry: string
): string[] {
  return exclusionList.filter((item) => item !== entry);
}

function isPageEntry(entry: string): boolean {
  return entry.includes("/");
}

function getDomain(entry: string): string {
  return entry.split("/")[0];
}

export type ExclusionListEntry = { domain: string; path: string; page: string };

export function urlToExclusionListEntry(url: string): ExclusionListEntry {
  const u = new URL(url);
  return {
    domain: u.host,
    path: u.pathname,
    page: u.host + u.pathname,
  };
}
