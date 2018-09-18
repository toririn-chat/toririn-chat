const { environment } = require('@rails/webpacker')

const vue = require('./loaders/vue')
environment.loaders.append('vue', vue)

const custom = require('./custom')
environment.config.merge(custom)

module.exports = environment
