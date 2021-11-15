import { checkBrowser } from "./check";

describe("checkBrowser", () => {
  test("test Safari on mac", () => {
    expect(
      checkBrowser(
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36",
        false
      )
    ).toBe(false);
  });
  test("test Chrome on iphone", () => {
    expect(
      checkBrowser(
        "Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/95.0.4638.50 Mobile/15E148 Safari/604.1",
        true
      )
    ).toBe(false);
  });
  test("test FireFox on iphone", () => {
    expect(
      checkBrowser(
        "Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) FxiOS/39.0 Mobile/15E148 Safari/605.1.15",
        true
      )
    ).toBe(false);
  });
  test("test Safari on iPad", () => {
    expect(
      checkBrowser(
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.152 Safari/537.36",
        true
      )
    ).toBe(true);
  });
  test("test Safari on iPhone", () => {
    expect(
      checkBrowser(
        "Mozilla/5.0 (iPhone; CPU iPhone OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.1 Mobile/15E148 Safari/604.1",
        true
      )
    ).toBe(true);
  });
  test("test Chrome on iPad", () => {
    expect(
      checkBrowser(
        "Mozilla/5.0 (iPad; CPU OS 15_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/96.0.4664.36 Mobile/15E148 Safari/604.1",
        true
      )
    ).toBe(false);
  });
});
