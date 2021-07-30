import { computeVectorMagnitude } from "./computeVectorMagnitude";

describe("computeVectorMagnitude", () => {
  test("calculate magnitude", () => {
    expect(computeVectorMagnitude({ x: 3, y: 4 })).toBe(5);
  });
  test("zero magnitude", () => {
    expect(computeVectorMagnitude({ x: 0, y: 0 })).toBe(0);
  });
});
