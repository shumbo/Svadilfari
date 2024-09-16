import { Gesture, Pattern } from "./SharedTypes";
import { computeVectorMagnitude } from "./utils/computeVectorMagnitude";
import { vectorDirectionDifference } from "./utils/vectorDirectionDifference";

export function getClosestGestureByPattern(
  pattern: Pattern,
  gestures: Set<Gesture>,
  maxDeviation = 1,
): Gesture | null {
  let bestMatchingGesture: Gesture | null = null;
  let lowestMismatchRatio = Infinity;
  for (const gesture of gestures) {
    const differenceByDTW = patternSimilarityByDTW(pattern, gesture.pattern);
    // pre-filter gestures by DTW deviation value to increase speed
    if (differenceByDTW > maxDeviation) continue;

    const differenceByProportion = patternSimilarityByProportion(
      pattern,
      gesture.pattern,
    );

    const difference = differenceByDTW + differenceByProportion;

    if (difference < lowestMismatchRatio) {
      lowestMismatchRatio = difference;
      bestMatchingGesture = gesture;
    }
  }
  return bestMatchingGesture;
}

/**
 * Returns the similiarity value of 2 patterns
 * Range: [0, 1]
 * 0 = perfect match / identical
 * 1 maximum mismatch
 **/
export function patternSimilarityByProportion(
  patternA: Pattern,
  patternB: Pattern,
): number {
  const totalAMagnitude = patternMagnitude(patternA);
  const totalBMagnitude = patternMagnitude(patternB);

  let totalDifference = 0;

  let a = 0;
  let b = 0;

  let vectorAMagnitudeProportionStart = 0;
  let vectorBMagnitudeProportionStart = 0;

  while (a < patternA.data.length && b < patternB.data.length) {
    const vectorA = patternA.data[a];
    const vectorB = patternB.data[b];

    const vectorAMagnitude = computeVectorMagnitude(vectorA);
    const vectorBMagnitude = computeVectorMagnitude(vectorB);

    const vectorAMagnitudeProportion = vectorAMagnitude / totalAMagnitude;
    const vectorBMagnitudeProportion = vectorBMagnitude / totalBMagnitude;

    const vectorAMagnitudeProportionEnd =
      vectorAMagnitudeProportionStart + vectorAMagnitudeProportion;
    const vectorBMagnitudeProportionEnd =
      vectorBMagnitudeProportionStart + vectorBMagnitudeProportion;

    // calculate how much both vectors are overlapping
    const overlappingMagnitudeProportion = overlapProportion(
      vectorAMagnitudeProportionStart,
      vectorAMagnitudeProportionEnd,
      vectorBMagnitudeProportionStart,
      vectorBMagnitudeProportionEnd,
    );

    // compare which vector magnitude proportion is larger / passing over the other vector
    // take the pattern with the smaller magnitude proportion and increase its index
    // so the next vektor of this pattern will be compared next

    if (vectorAMagnitudeProportionEnd > vectorBMagnitudeProportionEnd) {
      // increase B pattern index / take the next B vektor in the next iteration
      b++;
      // set current end to new start
      vectorBMagnitudeProportionStart = vectorBMagnitudeProportionEnd;
    } else if (vectorAMagnitudeProportionEnd < vectorBMagnitudeProportionEnd) {
      // increase A pattern index / take the next A vektor in the next iteration
      a++;
      // set current end to new start
      vectorAMagnitudeProportionStart = vectorAMagnitudeProportionEnd;
    } else {
      // increase A & B pattern index / take the next A & B vektor in the next iteration
      a++;
      b++;
      // set current end to new start
      vectorAMagnitudeProportionStart = vectorAMagnitudeProportionEnd;
      vectorBMagnitudeProportionStart = vectorBMagnitudeProportionEnd;
    }

    // calculate the difference of both vectors
    // this will result in a value of 0 - 1
    const vectorDifference = Math.abs(
      vectorDirectionDifference(vectorA, vectorB),
    );

    // weight the value by its corresponding magnitude proportion
    // all magnitude proportion should add up to a value of 1 in total (ignoring floating point errors)
    totalDifference += vectorDifference * overlappingMagnitudeProportion;
  }

  return totalDifference;
}

/**
 * Modified version of dynmaic time warping algorithm
 * Range: [0, 1]
 * 0 = perfect match / identical
 * 1 maximum mismatch
 **/
export function patternSimilarityByDTW(
  patternA: Pattern,
  patternB: Pattern,
): number {
  const rows = patternA.data.length;
  const columns = patternB.data.length;

  if (rows === 0 || columns === 0) {
    return 1;
  }

  // create 2-dimensional array
  const DTW = Array.from(Array(rows), () => Array(columns).fill(Infinity));

  for (let i = 0; i < rows; i++) {
    for (let j = 0; j < columns; j++) {
      const cost = Math.abs(
        vectorDirectionDifference(patternA.data[i], patternB.data[j]),
      );

      if (i !== 0 && j !== 0) {
        DTW[i][j] =
          cost + Math.min(DTW[i - 1][j], DTW[i][j - 1], DTW[i - 1][j - 1]);
      } else if (i !== 0) {
        DTW[i][j] = cost + DTW[i - 1][j];
      } else if (j !== 0) {
        DTW[i][j] = cost + DTW[i][j - 1];
      } else {
        DTW[i][j] = cost;
      }
    }
  }

  // divide by amount of vectors
  return DTW[rows - 1][columns - 1] / Math.max(rows, columns);
}

/**
 * Calculates the overlap range of 2 line segments
 **/
function overlapProportion(
  minA: number,
  maxA: number,
  minB: number,
  maxB: number,
) {
  return Math.max(0, Math.min(maxA, maxB) - Math.max(minA, minB));
}

/**
 * Calculates the length/magnitude of a pattern
 **/
function patternMagnitude(pattern: Pattern) {
  return pattern.data
    .map((v) => computeVectorMagnitude(v))
    .reduce((accm, curr) => accm + curr, 0);
}
