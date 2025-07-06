const { getDefaultConfig } = require('@expo/metro-config');

const config = getDefaultConfig(__dirname);

config.resolver.alias = {
  '@': './src',
  '@/components': './src/components',
  '@/screens': './src/screens',
  '@/services': './src/services',
  '@/types': './src/types',
  '@/utils': './src/utils',
  '@/context': './src/context',
  '@/assets': './assets',
};

module.exports = config;
