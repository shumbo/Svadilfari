import { Pattern, Point, Vector } from "./SharedTypes";
import { computeVectorMagnitude } from "./utils/computeVectorMagnitude";
import { makeVectorFromPoints } from "./utils/makeVectorFromPoints";
import { vectorDirectionDifference } from "./utils/vectorDirectionDifference";

export class PatternConstructor {
  private differenceThreshold: number;
  private distanceThreshold: number;
  private lastExtractedPoint: Point | null = null;
  private previousPoint: Point | null = null;
  private lastPoint: Point | null = null;
  private previousVector: Vector | null = null;
  private extractedVectors: Vector[] = [];
  constructor(differenceThreshold: number, distanceThreshold: number) {
    this.differenceThreshold = differenceThreshold;
    this.distanceThreshold = distanceThreshold;
  }
  public clear(): void {
    this.lastExtractedPoint = null;
    this.previousPoint = null;
    this.lastPoint = null;
    this.previousVector = null;
    this.extractedVectors = [];
  }
  /**
   * Add a point to the constrcutor
   * Returns an integer value:
   * 1 if the added point passed the distance threshold
   * 2 if the added point also passed the difference threshold
   * else 0
   **/
  public addPoint(point: Point): 0 | 1 | 2 {
    let changeIndicator = 0 as const;

    // on first point / if no previous point exists
    if (!this.previousPoint) {
      // set first extracted point
      this.lastExtractedPoint = point;
      // set previous point to first point
      this.previousPoint = point;
    } else {
      const vector = makeVectorFromPoints(this.previousPoint, point);
      if (computeVectorMagnitude(vector) > this.distanceThreshold) {
        // on second point / if no previous vector exists
        if (!this.previousVector) {
          this.previousVector = vector;
        } else {
          // calculate vector direction difference
          const diff = vectorDirectionDifference(this.previousVector, vector);
          if (Math.abs(diff) > this.differenceThreshold) {
            // store new extraced
            this.extractedVectors.push(
              // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
              makeVectorFromPoints(
                this.lastExtractedPoint!,
                this.previousPoint,
              ),
            );
            this.previousVector = vector;
            this.lastExtractedPoint = this.previousPoint;
            changeIndicator += 1;
          }
        }
        this.previousPoint = point;
        changeIndicator += 1;
      }
    }

    // always store the last point
    this.lastPoint = point;
    return changeIndicator as 0 | 1 | 2;
  }
  public getPattern(): Pattern {
    if (!this.lastPoint || !this.lastExtractedPoint) {
      return { data: [] };
    }
    const lastVector = makeVectorFromPoints(
      this.lastExtractedPoint,
      this.lastPoint,
    );
    return { data: [...this.extractedVectors, lastVector] };
  }
}
