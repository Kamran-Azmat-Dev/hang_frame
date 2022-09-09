const deserializeMouldingTypePrice = (mouldingTypePrice) => ({
  ...mouldingTypePrice,
  price: parseFloat(mouldingTypePrice.price),
});

const deserializeMountTypePreference = (mountTypePreference) => ({
  ...mountTypePreference,
  price: parseFloat(mountTypePreference.price),
});

const deserializeMountType = (mountType) => ({
  ...mountType,
  price: parseFloat(mountType.price),
  width: parseFloat(mountType.width),
  height: parseFloat(mountType.height),
  preferences: mountType.preferences.map(deserializeMountTypePreference),
});

const deserializeMountOption = (mountOption) => ({
  ...mountOption,
  price: parseFloat(mountOption.price),
  left: parseFloat(mountOption.left),
  right: parseFloat(mountOption.right),
  top: parseFloat(mountOption.top),
  bottom: parseFloat(mountOption.bottom),
});

const deserializeAdditional = (additional) => ({
  ...additional,
  price: parseFloat(additional.price),
});

const foilBlockingAdditionalName = "foil_blocking";
const linenAdditionalName = "linen";

export const deserializeAvailableCustomizationOptions = (data) => {
  const {
    printSizeId,
    mouldingTypePrices,
    mountTypes,
    mountOptions,
    additionals,
  } = data;

  const deserializedMouldingTypePrices = mouldingTypePrices.map(
    deserializeMouldingTypePrice
  );
  const deserializedMountTypes = mountTypes.map(deserializeMountType);
  const deserializedMountOptions = mountOptions.map(deserializeMountOption);
  const deserializedAdditionals = additionals.map(deserializeAdditional);

  const foilBlockingAdditional = deserializedAdditionals.find(
    (e) => e.name === foilBlockingAdditionalName
  );
  const linenAdditional = deserializedAdditionals.find(
    (e) => e.name === linenAdditionalName
  );

  return {
    printSizeId,
    mouldingTypePrices: deserializedMouldingTypePrices,
    mountTypes: deserializedMountTypes,
    mountOptions: deserializedMountOptions,
    foilBlockingAdditional,
    linenAdditional,
  };
};
