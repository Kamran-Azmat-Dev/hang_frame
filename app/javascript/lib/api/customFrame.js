import axios from 'axios'

export const fetchChevrons = async (chevronsPath) => {
  const result = await axios.get(chevronsPath)
  return result.data.chevrons
}

export const fetchCustomFrame = async (showProductPath, productSlug) => {
  const route = showProductPath.replace(':id', productSlug)
  const result = await axios.get(route)
  return result.data.product
}

export const fetchStandardFrame = async (showProductPath, productSlug) => {
  const route = showProductPath.replace(':id', productSlug)
  const result = await axios.get(route)
  return result.data.product
}
