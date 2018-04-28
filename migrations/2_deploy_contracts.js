var Pool = artifacts.require("./Pools/Pool.sol");
var DRM = artifacts.require("./DRM/DRM.sol");



var wallet = '0x627306090abaB3A6e1400e9345bC60c78a8BEf57';

module.exports = function (deployer) {
    deployer.deploy(Pool, ).then(function () {
        return deployer.deploy(DRM, Pool.address, 20, wallet, Rico.address, 150000000000000);
    })
};