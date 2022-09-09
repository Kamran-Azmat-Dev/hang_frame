export const defaultMountDimensions = (mountOption) => {
  return {
    left: mountOption.left,
    right: mountOption.right,
    top: mountOption.top,
    bottom: mountOption.bottom,
  };
};

const findMatchingMountTypePreference = (mountDimensions, mountType) => {
  const { left, top } = mountDimensions;
  const mountDimensionsCombined = left + top;

  return mountType.preferences.find((e) => {
    return (
      e.minValue <= mountDimensionsCombined &&
      mountDimensionsCombined <= e.maxValue
    );
  });
};

export const customFramePrice = (options) => {
  const {
    variant,
    mouldingTypePrices,
    mountType,
    mountDimensions,
    mountOption,
    foilBlockingAdditional,
    linenAdditional,
    product,
  } = options;

  const components = [];
  if (product.isCustom) {
    const mouldingTypePrice = mouldingTypePrices.find(
      (e) => e.mouldingTypeId === variant.mouldingTypeId
    );
    if (!mouldingTypePrice) {
      return undefined;
    }

    components.push(mouldingTypePrice.price);
    components.push(mountType.price);

    if (mountType.preferences.length > 0) {
      const preference = findMatchingMountTypePreference(
        mountDimensions,
        mountType
      );

      if (preference) {
        components.push(preference.price);
      } else {
        return undefined;
      }
    } else {
      components.push(mountOption.price);
    }

    if (foilBlockingAdditional) {
      components.push(foilBlockingAdditional.price);
    }

    if (linenAdditional) {
      components.push(linenAdditional.price);
    }
  } else {
    components.push(variant.price);
    if (foilBlockingAdditional) {
      components.push(foilBlockingAdditional.price);
    }
  }

  return components.reduce((sum, e) => sum + e);
};
