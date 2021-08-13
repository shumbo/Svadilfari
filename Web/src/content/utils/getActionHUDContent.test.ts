import { getActionHUDContent } from "./getActionHUDContent";

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
