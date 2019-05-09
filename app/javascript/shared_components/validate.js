export const required = value => value ? false : 'Champs Obligatoire'
export const customRequired= text => value => value ? false : `${text}`
export const number = value => value && isNaN(Number(value)) ? 'Veuillez enter un chiffre' : false
export const minValue = min => value => value && value < min ? `Valeur minimum ${min}` : false
export const maxValue = max => value => value && value > max ? `Valeur maximum ${max}` : false
export const betweenValues = (min, max) => value => value && (value > max || value < min) ? `Valeur entre ${min} et ${max}` : false
export const minLength = min => value => value && value.length < min ? `Minimum ${min} characters` : false
export const maxLength = max => value => value && value.length > max ? `Maximum ${max} characters` : false
