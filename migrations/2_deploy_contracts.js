var Registry = artifacts.require("Registry");

module.exports = function(deployer) {
  deployer.deploy(Registry, 'Name');
};