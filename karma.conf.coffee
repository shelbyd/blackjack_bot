module.exports = (config) =>
  config.set
    frameworks: ['jasmine']
    preprocessors:
      '**/*.coffee': ['coffee']
