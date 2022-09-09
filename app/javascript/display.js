export const formatFrameDimension = (dimension) => {
  if (Number.isInteger(dimension)) {
    return dimension.toString()
  }

  return dimension.toFixed(1)
}
