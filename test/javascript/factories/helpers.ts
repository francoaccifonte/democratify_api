export const buildList = <T>(generator: () => T, amt: number): T[] => {
  const results: T[] = []

  for (let i = 0; i < amt; i++) {
    results.push(generator())
  }

  return results
}
