export const deserializeVariant = (variant) => ({
  ...variant,
  price: parseFloat(variant.price),
})
