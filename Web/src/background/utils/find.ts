/**
 * Given an array, search the target and return the element next to it
 * @param data
 * @param target
 */
export function findNext<T>(data: T[], target: T): T | null {
  for (let i = 0; i < data.length - 1; i++) {
    if (data[i] === target) {
      return data[i + 1];
    }
  }
  if (data[data.length - 1] === target) {
    return data[0];
  }
  return null;
}

export function findPrevious<T>(data: T[], target: T): T | null {
  const reversed = data.slice().reverse();
  return findNext(reversed, target);
}
