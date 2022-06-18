const Kryptobird = artifacts.require("Kryptobird");

module.exports = function(deployer) {
    deployer.deploy(Kryptobird);
};