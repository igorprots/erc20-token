// var erc20BMT = artifacts.require("ERC20Standard");

// module.exports = function (deployer) {
//     deployer.deploy(erc20BMT);
// };

var erc20BMT = artifacts.require("ERC20Distributed");

module.exports = function (deployer) {
    deployer.deploy(erc20BMT);
};
