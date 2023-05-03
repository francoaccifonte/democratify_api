export const json_to = <Type>(json: string): Type => {
  return JSON.parse(json) as Type
}
