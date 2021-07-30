import { vectorDirectionDifference } from "./vectorDirectionDifference";

describe("vectorDirectionDifference", () => {
  test("same vector", () => {
    expect(vectorDirectionDifference({ x: 1, y: 1 }, { x: 2, y: 2 })).toBe(0);
  });
  test("opposite 1", () => {
    expect(vectorDirectionDifference({ x: 1, y: 1 }, { x: -1, y: -1 })).toBe(1);
  });
  test("opposite 2", () => {
    expect(vectorDirectionDifference({ x: -1, y: 1 }, { x: 1, y: -1 })).toBe(1);
  });
  test("-3/4*PI", () => {
    expect(vectorDirectionDifference({ x: 0, y: -1 }, { x: -1, y: 1 })).toBe(
      -0.75
    );
  });
  test("3/4*PI", () => {
    expect(vectorDirectionDifference({ x: -1, y: 1 }, { x: 0, y: -1 })).toBe(
      0.75
    );
  });
});
