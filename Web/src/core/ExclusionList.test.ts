import {
  addToExclusionList,
  isExcluded,
  removeFromExclusionList,
  urlToExclusionListEntry,
} from "./ExclusionList";

describe("isExcluded", () => {
  const table = [
    { name: "empty list", list: [], entry: "example.com", expected: false },
    {
      name: "domain match",
      list: ["case1.example.com", "case2.example.com"],
      entry: "case2.example.com",
      expected: true,
    },
    {
      name: "domain match with path",
      list: ["domain.example.com"],
      entry: "domain.example.com/foo",
      expected: true,
    },
    {
      name: "domain not match",
      list: ["case1.example.com", "case2.example.com"],
      entry: "example.com",
      expected: false,
    },
    {
      name: "page match",
      list: ["page.example.com/foo"],
      entry: "page.example.com/foo",
      expected: true,
    },
    {
      name: "page not match",
      list: ["page.example.com/foo"],
      entry: "page.example.com/bar",
      expected: false,
    },
  ];
  for (const { name, list, entry, expected } of table) {
    test(name, () => {
      expect(isExcluded(list, entry)).toBe(expected);
    });
  }
});

describe("addToExclusionList", () => {
  const table = [
    {
      name: "add domain",
      list: ["foo.example.com"],
      entry: "example.com",
      expected: ["foo.example.com", "example.com"],
    },
    {
      name: "add page",
      list: ["example.com/foo"],
      entry: "example.com/bar",
      expected: ["example.com/foo", "example.com/bar"],
    },
    {
      name: "add domain entry and page entries are removed",
      list: ["example.com/foo", "example.com/bar"],
      entry: "example.com",
      expected: ["example.com"],
    },
  ];
  for (const { name, list, entry, expected } of table) {
    test(name, () => {
      expect(addToExclusionList(list, entry).sort()).toEqual(expected.sort());
    });
  }
});

describe("removeFromExclusionList", () => {
  const table = [
    {
      name: "noop",
      list: ["foo.example.com"],
      entry: "bar.example.com",
      expected: ["foo.example.com"],
    },
    {
      name: "remove page",
      list: ["example.com/foo"],
      entry: "example.com/foo",
      expected: [],
    },
    {
      name: "remove domain",
      list: ["example.com/foo", "domain.example.com"],
      entry: "domain.example.com",
      expected: ["example.com/foo"],
    },
  ];
  for (const { name, list, entry, expected } of table) {
    test(name, () => {
      expect(removeFromExclusionList(list, entry).sort()).toEqual(
        expected.sort()
      );
    });
  }
});

describe("urlToExclusionListEntry", () => {
  test("root", () => {
    expect(urlToExclusionListEntry("http://example.com")).toEqual({
      domain: "example.com",
      path: "/",
      page: "example.com/",
    });
  });
  test("non-root", () => {
    expect(urlToExclusionListEntry("http://example.com/foo")).toEqual({
      domain: "example.com",
      path: "/foo",
      page: "example.com/foo",
    });
  });
});
