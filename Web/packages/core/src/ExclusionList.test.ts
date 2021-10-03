import { urlToExclusionListEntry } from "./ExclusionList";

describe("urlToExclusionListEntry", () => {
  test("root", () => {
    expect(urlToExclusionListEntry("http://example.com")).toEqual({
      domain: "example.com",
      path: "/",
    });
  });
  test("non-root", () => {
    expect(urlToExclusionListEntry("http://example.com/foo")).toEqual({
      domain: "example.com",
      path: "/foo",
    });
  });
});
