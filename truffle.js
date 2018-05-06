var HDWalletProvider = require("truffle-hdwallet-provider");
var mnemonic = "nerve clever boil cube same robust genre floor between goat cheese lady";

module.exports = {
    networks: {
        ropsten: {
            provider: function() {
                return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/PNBAkpo8ozY9YxcN5EcS")
            },
            network_id: 3,
            gas: 4612388,
            gasPrice: 22000000000
        },
        rinkeby: {
            provider: function() {
                return new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/PNBAkpo8ozY9YxcN5EcS")
            },
            network_id: 3,
            gas: 4612388,
            gasPrice: 22000000000
        },
        ganache: {
            host: "localhost",
            port: 7545,
            network_id: 5777
        }
    }
};