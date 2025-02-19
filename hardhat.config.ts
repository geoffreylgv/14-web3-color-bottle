import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config()

const { ALCHEMY_ETH_API_KEY_URL, ALCHEMY_SEPOLIA_API_KEY_URL, ACCOUNT_PRIVATE_KEY, ETHERSCAN_API_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.28",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    //  hardhat: {
    //   forking: {
    //     url: ALCHEMY_ETH_API_KEY_URL as string,
    //   }
    // },
    // ethereum: {
    //   url: ALCHEMY_ETH_API_KEY_URL,
    //   accounts: [`0x${ACCOUNT_PRIVATE_KEY}`],
    // },
    sepolia: {
      url: ALCHEMY_SEPOLIA_API_KEY_URL,
      accounts: [`0x${ACCOUNT_PRIVATE_KEY}`],
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};

export default config;
