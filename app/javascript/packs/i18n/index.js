import Vue from 'vue'
import VueI18N from 'vue-i18n'
Vue.use(VueI18N)

import ja from './ja'

const messages = {
  ja: ja
}
export default new VueI18N({ locale: 'ja', fallbackLocale: 'ja', messages })
