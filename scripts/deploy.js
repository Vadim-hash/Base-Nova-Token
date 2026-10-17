const hre = require("hardhat");

async function main() {
  const Token = await hre.ethers.getContractFactory("NexusToken"); // Замени на имя своего контракта
  const token = await Token.deploy();
  await token.deployed();
  console.log("Token deployed to:", token.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
