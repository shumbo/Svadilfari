import { Vector } from "../../SharedTypes";

export function computeVectorMagnitude(v: Vector) {
  return Math.hypot(v.x, v.y);
}
