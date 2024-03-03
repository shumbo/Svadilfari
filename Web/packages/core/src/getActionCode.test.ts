import { getActionCode } from "./getActionCode";

describe("getActionCode", () => {
  test("can get code", () => {
    expect(getActionCode({ reload: true })).toBe("reload");
    expect(getActionCode({ javascriptRun: { code: "alert('hello')" } })).toBe(
      "javascriptRun",
    );
  });
  test("empty action", () => {
    expect(getActionCode({})).toBeNull();
  });
  test("key only", () => {
    expect(getActionCode({ reload: false })).toBeNull();
  });
});
