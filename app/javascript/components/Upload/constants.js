export const digitalUploadTypes = {
  standard: {
    id: 'standard',
    label: 'Art/Prints/Photographs/ \nCertificates',
    details: [
      'Fully custom sizes and styles',
      'Frame personalisation',
      '4-8 days delivery'
    ],
    specialDetails: [],
  },
  custom: {
    id: 'custom',
    label: 'Custom Frame Digital \nPhotos',
    details: [
      'Fully custom sizes and styles',
      'Frame personalisation',
      '2-6 days delivery',
    ],
    specialDetails: []
  }
}

export const originalUploadTypeId = 'original'
export const minSide = 10
export const originalArtMinSide = 5
export const maxShortestSide = 60
export const maxLongestSide = 140
export const maxFrameLongestSide = 112
export const maxFrameShortestSide = 81.5
export const minDpi = 150
export const inchToCm = 2.54

export const cropPresets = [
  {
    label: 'Square',
    key: 'square',
    aspectRatio: 1,
  },
  {
    label: 'Portrait',
    key: 'portrait',
    aspectRatio: 0.75,
  },
  {
    label: 'Landscape',
    key: 'landscape',
    aspectRatio: 4 / 3,
  },
  {
    label: 'Custom (Freeform)',
    key: 'freeform',
    aspectRatio: undefined,
  },
]
