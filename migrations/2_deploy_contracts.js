var Pool = artifacts.require("./Pools/Pool.sol");
var DRM = artifacts.require("./DRM/DRM.sol");
var Fors = artifacts.require("./Fors.sol");
var PoolFactory = artifacts.require("./Pools/PoolFactory.sol");
var DRMFactory = artifacts.require("./DRM/DRMFactory.sol");



var wallet = '0x627306090abaB3A6e1400e9345bC60c78a8BEf57';


module.exports = function (deployer) {
    deployer.deploy(Fors).then(function () {
        return deployer.deploy(PoolFactory, Fors.address);
    }).then(function () {
        return deployer.deploy(DRMFactory);
    })
};

