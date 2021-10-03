import { Vector } from "../SharedTypes";

/**
 * Returns the dierection difference of 2 vectors
 * Range: (-1, 0, 1]
 * 0 = same direction
 * 1 = opposite direction
 * + and - indicate if the direction difference is counter clockwise (+) or clockwise (-)
 **/
export function vectorDirectionDifference(v1: Vector, v2: Vector): number {
  let angleDifference = Math.atan2(v1.y, v1.x) - Math.atan2(v2.y, v2.x);
  if (angleDifference > Math.PI) {
    angleDifference = 2 * Math.PI - angleDifference;
  } else if (angleDifference <= -Math.PI) {
    angleDifference = -(2 * Math.PI + angleDifference);
  }
  return angleDifference / Math.PI;
}
