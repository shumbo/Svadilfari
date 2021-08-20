export type ExclusionListEntry = { domain: string; path: string };

export function urlToExclusionListEntry(url: string): ExclusionListEntry {
  const u = new URL(url);
  return {
    domain: u.host,
    path: u.pathname,
  };
}
