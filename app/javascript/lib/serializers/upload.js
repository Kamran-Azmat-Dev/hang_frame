export const deserializeUpload = (data) => {
  let deserializedMouldingTypePrices
  if (data.mouldingTypePrices) {
    deserializedMouldingTypePrices = data.mouldingTypePrices.map(e => ({
      ...e,
      price: parseFloat(e.price),
    }))
  }

  return {
    uuid: data.uuid,
    status: data.status,
    uploadType: data.hangType,
    photoUrl: data.croppedPhotoUrl,
    originalPhotoUrl: data.photoUrl,
    isCustom: data.isCustom,
    printWidth: parseFloat(data.printWidth),
    printHeight: parseFloat(data.printHeight),
    printSizeId: data.printSizeOptionValueId,
    mouldingTypePrices: deserializedMouldingTypePrices,
  }
}

export const serializeUploadCrop = (uploadUUID, croppedSize, uploadTypeId, printSize) => {
  return {
    uuid: uploadUUID,
    left: croppedSize.left,
    top: croppedSize.top,
    width: croppedSize.width,
    height: croppedSize.height,
    type: uploadTypeId,
    print_size_option_value_id: printSize.optionValueId,
    print_width: printSize.width.toString(),
    print_height: printSize.height.toString(),
  }
}
