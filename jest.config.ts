import type { Config } from 'jest';

const config: Config = {
  verbose: true,
  testEnvironment: 'jsdom',
  roots: ["test/javascript"],
  setupFiles: ['./test/javascript/jestHelper.ts'],
};

export default config;