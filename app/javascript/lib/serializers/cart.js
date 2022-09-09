const deserializeHangPhoto = (lineItemData, included) => {
  if (!lineItemData.relationships.hang_photo.data) {
    return;
  }

  const hangPhotoId = lineItemData.relationships.hang_photo.data.id;
  const data = included.find(
    (e) => e.id === hangPhotoId && e.type === "hang_photo"
  );

  return {
    photoUrl: data.attributes.url,
    uploadType: data.attributes.hang_type,
    printWidth: parseFloat(data.attributes.print_width),
    printHeight: parseFloat(data.attributes.print_height),
    uuid: data.attributes.uuid,
  };
};

const findAdjustmentsOfType = (lineItemData, included, type) => {
  const adjustmentIds = lineItemData.relationships.adjustments.data.map(
    (e) => e.id
  );
  const results = included.filter((e) => {
    return (
      adjustmentIds.includes(e.id) &&
      e.type === "adjustment" &&
      e.attributes.source_type === type
    );
  });

  return results;
};

const findAdjustmentOfType = (lineItemData, included, type) => {
  const results = findAdjustmentsOfType(lineItemData, included, type);
  return results[0];
};

const deserializeMountDimensions = (lineItemData, included) => {
  const data = findAdjustmentOfType(
    lineItemData,
    included,
    "CustomFrame::MountType"
  );

  if (!data) {
    return;
  }

  return {
    top: parseFloat(data.attributes.mount_top),
    left: parseFloat(data.attributes.mount_left),
    bottom: parseFloat(data.attributes.mount_bottom),
    right: parseFloat(data.attributes.mount_right),
  };
};

const deserializeMountType = (lineItemData, included) => {
  const data = findAdjustmentOfType(
    lineItemData,
    included,
    "CustomFrame::MountType"
  );

  if (!data) {
    return;
  }

  return {
    id: parseInt(data.attributes.source_id, 10),
  };
};

const deserializeMountOption = (lineItemData, included) => {
  const data = findAdjustmentOfType(
    lineItemData,
    included,
    "CustomFrame::MountOption"
  );

  if (!data) {
    return;
  }

  return {
    id: parseInt(data.attributes.source_id, 10),
  };
};

const deserializeAdditionals = (lineItemData, included) => {
  const results = findAdjustmentsOfType(
    lineItemData,
    included,
    "CustomFrame::Additional"
  );
  const linenMountData = results.find((e) => e.attributes.notes === "linen");
  const foilBlockingData = results.find((e) =>
    e.attributes.notes.startsWith("foil_blocking")
  );

  let foilBlockingAdjustment;
  if (foilBlockingData) {
    const notes = foilBlockingData.attributes.notes;

    foilBlockingAdjustment = {
      chosen: true,
      ...JSON.parse(notes.substring("foil_blocking".length + 1)),
    };
  } else {
    foilBlockingAdjustment = {
      chosen: false,
      line1: undefined,
      line2: undefined,
    };
  }

  return {
    linenChosen: linenMountData !== undefined,
    foilBlocking: foilBlockingAdjustment,
  };
};

const deserializeFramePreviewImages = (variantData, included) => {
  const framePreviewImageIds = variantData.relationships.frame_preview_images.data.map(
    (e) => e.id
  );

  return included
    .filter(
      (e) =>
        framePreviewImageIds.includes(e.id) && e.type === "frame_preview_image"
    )
    .map((data) => ({
      name: data.attributes.name,
      borderWidth: data.attributes.border_width,
      borderPatternRepeats: data.attributes.border_pattern_repeats,
      borderPattern: data.attributes.border_pattern,
    }));
};

const deserializeMountColor = (lineItemData, included) => {
  if (!lineItemData.relationships.mount_color.data) {
    return;
  }

  const mountColorId = lineItemData.relationships.mount_color.data.id;
  const mountColor = included.find(
    (e) => e.id === mountColorId && e.type === "mount_color"
  );

  const mountPreviewImageIds = mountColor.relationships.mount_preview_images.data.map(
    (e) => e.id
  );
  const mountPreviewImagesData = included.filter(
    (e) =>
      mountPreviewImageIds.includes(e.id) && e.type === "mount_preview_image"
  );

  const images = mountPreviewImagesData.map((e) => ({
    name: e.attributes.name,
    mountPattern: e.attributes.pattern,
    mountPatternWidth: parseFloat(e.attributes.width),
    mountPatternHeight: parseFloat(e.attributes.height),
  }));

  return {
    id: parseInt(mountColorId, 10),
    regular: images.find((e) => e.name === "mount_pattern"),
    linen: images.find((e) => e.name === "mount_pattern"),
  };
};

const deserializeAccentMountColor = (lineItemData, included) => {
  if (!lineItemData.relationships.accent_mount_color.data) {
    return;
  }

  const mountColorId = lineItemData.relationships.accent_mount_color.data.id;
  const mountColor = included.find(
    (e) => e.id === mountColorId && e.type === "accent_mount_color"
  );

  const mountPreviewImageIds = mountColor.relationships.mount_preview_images.data.map(
    (e) => e.id
  );
  const mountPreviewImagesData = included.filter(
    (e) =>
      mountPreviewImageIds.includes(e.id) && e.type === "mount_preview_image"
  );

  const images = mountPreviewImagesData.map((e) => ({
    name: e.attributes.name,
    mountPattern: e.attributes.pattern,
    mountPatternWidth: parseFloat(e.attributes.width),
    mountPatternHeight: parseFloat(e.attributes.height),
  }));

  return {
    id: parseInt(mountColorId, 10),
    regular: images.find((e) => e.name === "mount_pattern"),
    linen: images.find((e) => e.name === "mount_pattern"),
  };
};

const deserializeVariantImage = (variantData, included) => {
  const variantImageIds = variantData.relationships.images.data.map(
    (e) => e.id
  );
  const variantImages = included.filter(
    (e) => variantImageIds.includes(e.id) && e.type === "image"
  );

  if (variantImages.length === 0) {
    return;
  }

  const mainImage = variantImages.reduce((prev, curr) =>
    curr.position < prev.position ? curr : prev
  );

  if (!mainImage) {
    return;
  }

  return {
    framePhotoUrl: mainImage.attributes.url,
    framePhotoWidth: parseInt(mainImage.attributes.width, 10),
    framePhotoHeight: parseInt(mainImage.attributes.height, 10),
    framePreviewX: mainImage.attributes.frame_preview_viewbox.x,
    framePreviewY: mainImage.attributes.frame_preview_viewbox.y,
    framePreviewWidth: mainImage.attributes.frame_preview_viewbox.width,
    framePreviewHeight: mainImage.attributes.frame_preview_viewbox.height,
  };
};

const deserializeLineItem = (lineItemId, included) => {
  const lineItemData = included.find(
    (e) => e.id === lineItemId && e.type === "line_item"
  );
  const variantData = included.find(
    (e) =>
      e.id === lineItemData.relationships.variant.data.id &&
      e.type === "variant"
  );
  const productData = included.find(
    (e) =>
      e.id === variantData.relationships.product.data.id && e.type === "product"
  );
  const hangPhoto = deserializeHangPhoto(lineItemData, included);
  const framePreviewImages = deserializeFramePreviewImages(
    variantData,
    included
  );
  const image = deserializeVariantImage(variantData, included);
  const mountDimensions = deserializeMountDimensions(lineItemData, included);
  const mountType = deserializeMountType(lineItemData, included);
  const mountOption = deserializeMountOption(lineItemData, included);
  const mountColor = deserializeMountColor(lineItemData, included);
  const accentMountColor = deserializeAccentMountColor(lineItemData, included);
  const additionals = deserializeAdditionals(lineItemData, included);

  return {
    id: parseInt(lineItemId, 10),
    variantId: parseInt(variantData.id, 10),
    name: lineItemData.attributes.name,
    isCustom: productData.attributes.custom,
    isDonation: productData.attributes.is_donation,
    isWrapped: productData.attributes.is_gift_wrapped,
    isPickup: productData.attributes.is_pickup,
    productSlug: productData.attributes.slug,
    displayTotal: lineItemData.attributes.display_total,
    quantity: lineItemData.attributes.quantity,
    image,
    framePreviewImages,
    mountType,
    mountOption,
    mountDimensions,
    hangPhoto,
    mountColor,
    accentMountColor,
    additionals,
  };
};

export const deserializeCart = (cart) => {
  const cartData = cart.data;
  const cartIncluded = cart.included;

  const lineItemIds = cartData.relationships.line_items.data.map((e) => e.id);
  const lineItems = lineItemIds.map((e) =>
    deserializeLineItem(e, cartIncluded)
  );

  const donationLineItem = lineItems.find((e) => e.isDonation);
  const regularLineItems = lineItems.filter((e) => !e.isWrapped || !e.isDonation || !e.isPickup);

  const giftWrapItem = lineItems.find((e) => e.isWrapped)
  const pickupItem = lineItems.find((e) => e.isPickup)

  const result = {
    framesItemsCount: cartData.attributes.frames_line_items_count,
    total: parseFloat(cartData.attributes.total) || 0,
    displayTotal: cartData.attributes.display_total,
    promotionTotal: parseFloat(cartData.attributes.promo_total) || 0,
    displayPromotionTotal: cartData.attributes.display_promo_total,
    lineItems: regularLineItems,
    treesForLifeItem: donationLineItem,
    giftWrapItem: giftWrapItem,
    pickupItem: pickupItem
  };
  return result;
};
