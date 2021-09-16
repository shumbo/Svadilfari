import { findNext, findPrevious } from "./find";

const arr = [0, 1, 2, 3, 4, 5];

describe("findNext", () => {
  test("top", () => {
    expect(findNext(arr, 0)).toBe(1);
  });
  test("middle", () => {
    expect(findNext(arr, 2)).toBe(3);
  });
  test("second to last", () => {
    expect(findNext(arr, 4)).toBe(5);
  });
  test("last", () => {
    expect(findNext(arr, 5)).toBe(0);
  });
  test("not found", () => {
    expect(findNext(arr, -1)).toBeNull();
  });
});

describe("findPrev", () => {
  test("top", () => {
    expect(findPrevious(arr, 0)).toBe(5);
  });
  test("second to top", () => {
    expect(findPrevious(arr, 1)).toBe(0);
  });
  test("middle", () => {
    expect(findPrevious(arr, 2)).toBe(1);
  });
  test("second to last", () => {
    expect(findPrevious(arr, 4)).toBe(3);
  });
  test("last", () => {
    expect(findPrevious(arr, 5)).toBe(4);
  });
  test("not found", () => {
    expect(findPrevious(arr, -1)).toBeNull();
  });
});
