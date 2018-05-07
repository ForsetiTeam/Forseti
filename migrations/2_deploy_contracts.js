var Pool = artifacts.require("./Pools/Pool.sol");
var DRM = artifacts.require("./DRM/DRM.sol");
var Fors = artifacts.require("./Fors.sol");
var PoolFactory = artifacts.require("./Pools/PoolFactory.sol");
var DRMFactory = artifacts.require("./DRM/DRMFactory.sol");



var wallet = '0x6B35d857486800768b5878eE2F827D7046a7dd6E';


module.exports = function (deployer) {
    deployer.deploy(Fors).then(function () {
        return deployer.deploy(PoolFactory, Fors.address);
    }).then(function () {
        return deployer.deploy(DRMFactory);
    })/*.then(function () {
        return deployer.deploy(DRM);
    })*/
};

