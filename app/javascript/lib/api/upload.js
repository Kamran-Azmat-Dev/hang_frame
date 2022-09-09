import axios from 'axios'
import { deserializeUpload, serializeUploadCrop } from '../serializers/upload'

export const fetchUpload = async (getPhotoPreviewPath, uploadUuid) => {
  const params = { uuid: uploadUuid }
  const response = await axios.get(getPhotoPreviewPath, { params })

  const data = response.data.data
  return deserializeUpload(data)
}

export const saveUploadCrop = async (updateCropDetailsPath, uploadUUID, croppedSize, uploadTypeId, printSize) => {
  const data = serializeUploadCrop(uploadUUID, croppedSize, uploadTypeId, printSize)
  const response = await axios.post(
    updateCropDetailsPath,
    data,
  )

  return response.data.data
}
