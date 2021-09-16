import { PatternConstructor } from "../core/PatternConstructor";
import { Convert } from "../SharedTypes";

export function pointsToPattern(json: string): string {
  const points = Convert.toPointList(json);
  const pc = new PatternConstructor(0.12, 40);
  for (const point of points) {
    pc.addPoint(point);
  }
  const pattern = pc.getPattern();
  return Convert.patternToJson(pattern);
}
