import { getActionCode, getActionHUDContent } from "./getActionHUDContent";

describe("getActionCode", () => {
  test("can get code", () => {
    expect(getActionCode({ reload: true })).toBe("reload");
    expect(getActionCode({ javascriptRun: { code: "alert('hello')" } })).toBe(
      "javascriptRun"
    );
  });
  test("empty action", () => {
    expect(getActionCode({})).toBeNull();
  });
});

describe("getActionHUDContent", () => {
  test("javascriptRun without description", () => {
    expect(
      getActionHUDContent({ javascriptRun: { code: "alert('hello')" } })?.title
    ).toBe("Run JavaScript");
  });
  test("javascriptRun with description", () => {
    expect(
      getActionHUDContent({
        javascriptRun: { code: "alert('hello')", description: "Say Hello" },
      })
    ).toMatchObject({ title: "Run JavaScript", message: "Say Hello" });
  });
});
