var Pool = artifacts.require("./Pools/Pool.sol");
var DRM = artifacts.require("./DRM/DRM.sol");
var Fors = artifacts.require("./Fors.sol");
var PoolFactory = artifacts.require("./Pools/PoolFactory.sol");
var DRMFactory = artifacts.require("./DRM/DRMFactory.sol");



var wallet = '0x6B35d857486800768b5878eE2F827D7046a7dd6E';
var token = '0xDbCf7344F1387C77089C3081F4513d0A1eDe3FF2';


module.exports = function (deployer) {
    deployer.deploy(PoolFactory, token).then(function () {
        return deployer.deploy(DRMFactory);
    })/*.then(function () {
        return deployer.deploy(DRM);
    })*/
};

