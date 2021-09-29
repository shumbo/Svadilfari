import { Point } from "../SharedTypes";
import { makeVectorFromPoints } from "./makeVectorFromPoints";

describe("makeVectorFromPoints", () => {
  test("generate a vector from the origin and a point", () => {
    const a: Point = {
      x: 0,
      y: 0,
    };
    const b: Point = {
      x: 2,
      y: 3,
    };
    const v = makeVectorFromPoints(a, b);
    expect(v.x).toBe(2);
    expect(v.y).toBe(3);
  });
  test("generate a vector from two points", () => {
    const a: Point = {
      x: 3,
      y: 9,
    };
    const b: Point = {
      x: -2,
      y: 0,
    };
    const v = makeVectorFromPoints(a, b);
    expect(v.x).toBe(-5);
    expect(v.y).toBe(-9);
  });
});
