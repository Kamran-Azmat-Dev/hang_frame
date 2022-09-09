import axios from "axios";
import { deserializeCart } from "../serializers/cart";

export const buildCartHeaders = () => {
  // TODO add user token if set
  const headers = {};

  headers["Accept"] = "application/json";
  headers["Content-Type"] = "application/json";
  return headers;
};

export const buildCartHeadersWithToken = (token) => ({
  ...buildCartHeaders(),
  "X-Spree-Order-Token": token,
});

export const ensureCart = async (routes) => {
  const cartTokenResponse = await axios.post(
    routes.ensureCartPath,
    {},
    { withCredentials: true }
  );
  return { token: cartTokenResponse.data.token };
};

export const fetchCart = async (routes, token) => {
  const requestToken = token ? token : (await ensureCart(routes)).token;
  const headers = buildCartHeadersWithToken(requestToken);
  const includedScopes = [
    "line_items.variant.product",
    "line_items.variant.images",
    "line_items.variant.frame_preview_images",
    "line_items.adjustments",
    "line_items.hang_photo",
    "line_items.mount_color.mount_preview_images",
    "line_items.accent_mount_color.mount_preview_images",
  ];
  const params = { include: includedScopes.join(",") };
  const cartResponse = await axios.get(routes.getCartPath, {
    headers,
    params,
  });

  return deserializeCart(cartResponse.data);
};

export const addItem = async (routes, variantId, options, token) => {
  const requestToken = token ? token : (await ensureCart(routes)).token;
  const headers = buildCartHeadersWithToken(requestToken);
  localStorage.removeItem("name");
  localStorage.removeItem("message");
  const payload = {
    variant_id: variantId,
    quantity: 1,
    options,
  };

 const {data} =  await axios.post(routes.addToCartPath, payload, { headers });
 let newData =  data.data.relationships.line_items.data;
 const id = newData[newData.length - 1].id
 localStorage.setItem(id, JSON.stringify(options));
};

export const makeAddNameAndMessage = async (
  routes,
  orderId,
  token,
  name,
  message
) => {
  const requestToken = token ? token : (await ensureCart(routes)).token;
  const headers = buildCartHeadersWithToken(requestToken);

  const payload = {
    order_id: orderId,
    name: name,
    message: message,
  };
  axios.post(routes.updateNameAndMessagePath, payload, { headers });
};

export const makeOriginalArtPackaging = async (
  routes,
  orderId,
  token,
  option,
) => {
  const requestToken = token ? token : (await ensureCart(routes)).token;
  const headers = buildCartHeadersWithToken(requestToken);

  const payload = {
    order_id: orderId,
    option,
  };
  axios.post(routes.addOriginalArtPackaging, payload, { headers });
};

export const removeItem = async (routes, item, token) => {
  const requestToken = token ? token : (await ensureCart(routes)).token;
  const headers = buildCartHeadersWithToken(requestToken);
  const removeLineItemPath = routes.removeLineItemPath.replace(":id", item.id);
  await axios.delete(removeLineItemPath, { headers });
};

export const changeItemQuantity = async (routes, item, quantity, token) => {
  const requestToken = token ? token : (await ensureCart(routes)).token;
  const headers = buildCartHeadersWithToken(requestToken);
  const payload = { quantity, line_item_id: item.id };
  await axios.patch(routes.changeLineItemQuantityPath, payload, { headers });
};

export const applyCouponCode = async (routes, code, token) => {
  const requestToken = token ? token : (await ensureCart(routes)).token;
  const headers = buildCartHeadersWithToken(requestToken);
  const payload = { coupon_code: code };
  await axios.patch(routes.applyCouponCodePath, payload, { headers });
};

export const removeCouponCode = async (routes, code, token) => {
  const requestToken = token ? token : (await ensureCart(routes)).token;
  const headers = buildCartHeadersWithToken(requestToken);
  const removeCouponCodePath = routes.removeCouponCodePath.replace(
    ":coupon_code",
    code
  );
  await axios.delete(removeCouponCodePath, { headers });
};
