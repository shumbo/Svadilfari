import { MockI18n } from "../../utils/MockI18n";
import { getActionHUDContent } from "./getActionHUDContent";

const i18n = new MockI18n();

describe("getActionHUDContent", () => {
  test("javascriptRun without description", () => {
    expect(
      getActionHUDContent({ javascriptRun: { code: "alert('hello')" } }, i18n)
        ?.title
    ).toBe("Run JavaScript");
  });
  test("javascriptRun with description", () => {
    expect(
      getActionHUDContent(
        {
          javascriptRun: { code: "alert('hello')", description: "Say Hello" },
        },
        i18n
      )
    ).toMatchObject({ title: "Run JavaScript", message: "Say Hello" });
  });
});
