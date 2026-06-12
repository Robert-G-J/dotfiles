const path = require('path');
// Derive global node_modules from the running node binary — works across NVM versions
const globalModules = path.join(path.dirname(process.execPath), '..', 'lib', 'node_modules');
const { startServer } = require(path.join(globalModules, 'graphql-language-service-server'));
startServer({ method: 'stream' });
