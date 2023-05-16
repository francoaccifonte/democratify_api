export const jsonTo = <Type>(json: string): Type => JSON.parse(json) as Type
export const toJson = <Type>(obj: Type): string => JSON.stringify(obj)
