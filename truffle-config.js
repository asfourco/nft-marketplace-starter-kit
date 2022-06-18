module.exports = {
  networks: {
    development: {
     host: "0.0.0.0",     // Localhost (default: none)
     port: 8545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
  },
  contracts_directory: './src/contracts',
  contracts_build_directory: './src/abis',
  compilers: {
    solc: {
      version: "^0.8.0",
      settings: {          // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: false,
          runs: 200
        },
      //  evmVersion: "byzantium"
      }
    }
  },
};
