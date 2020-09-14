module.exports = {

  networks: {
        devchain: {
            host: '127.0.0.1',   // accounts are already unlocked
            port: 8501,          // Custom port
            network_id: 666,     // devchain's id
            skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
        },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      // version: "0.5.1",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }
}
