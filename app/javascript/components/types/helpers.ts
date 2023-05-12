export const json_to = <Type>(json: string): Type => JSON.parse(json) as Type
export const to_json = <Type>(obj: Type): string => JSON.stringify(obj)
