const edf_path = require('../../assets/images/edf.png')
const total_path = require('../../assets/images/total.png')

export default function getImage (current_provider) {
  if (current_provider === 'EDF') return edf_path
  if (current_provider === 'Total') return total_path
}
