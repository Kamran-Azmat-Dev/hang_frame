import axios from "axios";
import { deserializeAvailableCustomizationOptions } from "../serializers/customization";

export const fetchAvailableCustomizationOptions = async (
  availableOptionsPath,
  uploadUuid
) => {
  const params = { uuid: uploadUuid };
  const result = await axios.get(availableOptionsPath, { params });
  const data = result.data.data;
  return deserializeAvailableCustomizationOptions(data);
};
