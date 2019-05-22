const edf_path = require('../../assets/images/edf.png')
const total_path = require('../../assets/images/total.png')
const antargaz_path = require('../../assets/images/antargaz.png')
const butagaz_path = require('../../assets/images/butagaz.png')
const ekwater_path = require('../../assets/images/ekwater.png')
const edsanterre_path = require('../../assets/images/energies-du-santerre.png')
const engie_path = require('../../assets/images/engie.png')
const eni_path = require('../../assets/images/eni.png')
const sowee_path = require('../../assets/images/sowee.png')
const totalspring_path = require('../../assets/images/totalspring.png')
const vattenfall_path = require('../../assets/images/vattenfall.png')

export default function getImage (current_provider) {
  if (current_provider === 'EDF') return edf_path
  if (current_provider === 'Total Direct Energie') return total_path
  if (current_provider === 'Total Spring') return totalspring_path
  if (current_provider === 'Engie') return engie_path
  if (current_provider === 'Butagaz') return butagaz_path
  if (current_provider === 'Vattenfall') return vattenfall_path
  if (current_provider === 'Ekwater') return ekwater_path
  if (current_provider === 'Antargaz') return antargaz_path
  if (current_provider === 'Energie du Santerre') return edsanterre_path
  if (current_provider === 'Eni') return eni_path
  if (current_provider === 'Sowee by EDF') return sowee_path

}
