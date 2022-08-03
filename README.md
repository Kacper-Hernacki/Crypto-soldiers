# This repo was created to not be stucked in tutorial hell and use knowledge from cryptozombies in passionate project

## Setup

1.  Create package.json `npm init -y`
2.  Installing dependencies`npm isntall`

## Instruction for first independently configuration

- Installing hardhat globally: `npx hardhat`
  above commend creates `hardhat.config.json` file

      ```json
      /\*_ @type import('hardhat/config').HardhatUserConfig _/
      module.exports = {
      solidity: "0.8.9",
      };

      ```

- Installing Hardhat locallly `npm install --save-dev hardhat`
- Creating Folder Struture:

  1.  `contracts` - folder where Solidity files are attached.
  2.  `scripts` - place where are stored hardhat scripts.
  3.  `test` - there lands test files

- Installing hardhat plugins: `npm install --save-dev @nomiclabs/hardhat-waffle @nomiclabs/hardhat-ethers ethereum-waffle chai ethers solidity-coverage `:

  1. `@nomiclabs/hardhat-waffle`: This is a Hardhat plugin that enables waffle support.
  2. `@nomiclabs/hardhat-ethers`: This is a Hardhat plugin that enables ethers support.
  3. `ethereum-waffle`: Waffle is a Solidity testing library. It allows you to write tests for your contracts with JavaScript.
  4. `chai`: Chai is an assertion library and provides functions like expect.
  5. `ethers`: This is a popular Ethereum client library. It allows you to interface with blockchains that implement the Ethereum API.
  6. `solidity-coverage`: This library gives you coverage reports on unit tests with the help of Istanbul.

- Including plugins

  ```js
    require("@nomiclabs/hardhat-waffle");
    require("solidity-coverage");

    /\*_ @type import('hardhat/config').HardhatUserConfig _/
    module.exports = {
    solidity: "0.8.9",
    };

  ```

- Adding Commands:
  In `package.json` under script add these lines:

      ```json
            "build": "hardhat compile",
            "test:light": "hardhat test",
            "test": "hardhat coverage",
      ```

  Above lines of code should execute: 1. `build` run smart contracts files from `contracts` folder. 2. `test:light` it invokes Waffle for testing contracts. 3. `test` it invokes Waffle tests and generates coverage.

- Implementing smart contract
  In `contracts/MyContract.sol` put code:

  ```sol
  // SPDX-License-Identifier: MIT

  pragma solidity >=0.7.0 <0.9.0;

  contract MyContract {
      string private name;

      constructor(string memory _name) {
          name = _name;
      }

      function changeName(string memory _name) public {
          name = _name;
      }

      function getName() public view returns (string memory) {
          return name;
      }
  }
  ```

- Compile contract by: `npm run build`
- testing:
  In `test/MyContract.test.js` put code:

        ```js
            const { expect } = require("chai");

            describe("MyContract", () => {
            it("should return its name", async () => {
                const MyContract = await ethers.getContractFactory("MyContract");
                const myContract = await MyContract.deploy("My Contract");

                await myContract.deployed();
                expect(await myContract.getName()).to.equal("My Contract");
            });
            it("should change its name when requested", async () => {
                const MyContract = await ethers.getContractFactory("MyContract");
                const myContract = await MyContract.deploy("My Contract");

                await myContract.changeName("Another Contract");
                expect(await myContract.getName()).to.equal("Another Contract");
            });
            });

        ```

- Run tests `npm run test`
- Deploying smart contract:
  In `scripts/deployMyContract.js` put:

            ```js
            async function main() {
                const MyContract = await ethers.getContractFactory("MyContract");
                const myContract = await MyContract.deploy("My Contract");

                console.log("My Contract deployed to:", myContract.address);
            }

            main()
                .then(() => process.exit(0))
                .catch((error) => {
                console.error(error);
                process.exit(1);
                });
            ```

- Add deploy command in `package.json`:
  `"deploy:local": "hardhat run --network localhost scripts/deployMyContract.js"`,
- Add local-testnet script in `package.json`: `"local-testnet": "hardhat node"`,
- Run local testnet: `npm run local-testnet`,
- deploy to local: `npm run deploy:local`
