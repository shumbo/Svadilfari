import { Vector } from "../../SharedTypes";

export function computeVectorMagnitude(v: Vector): number {
  return Math.hypot(v.x, v.y);
}
