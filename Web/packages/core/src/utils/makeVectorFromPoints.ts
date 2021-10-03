import { Point, Vector } from "../SharedTypes";

export function makeVectorFromPoints(from: Point, to: Point): Vector {
  return { x: to.x - from.x, y: to.y - from.y };
}
