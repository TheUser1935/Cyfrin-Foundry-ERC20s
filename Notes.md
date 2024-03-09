# Foundry ERC20's Lesson Notes

## Ethereum Improvement Proposals (EIPs)

Ethereum Improvement Proposals (EIPs) describe standards for the Ethereum platform, including core protocol specifications, client APIs, and contract standards. Network upgrades are discussed separately in the Ethereum Project Management repository

### What are EIPs?

The are proposals that people develop to improve Ethereum or improve thes layer 1's, like Polygon, Matic, Avalanche, etc.

The range of topics that EIPs could be is very broad, from best practises through to core blockchain improvements.

When an EIP has enough insight and information, they will become an ERC - Ethereum Request for Comments.

## Ethereum Request For Comments (ERC)

As ERCs are generated, they are assigned an incrementing number value for the order they are generated - e.g. ERC20 is the 20th ERC generated. This number value matches the number value of the EIP of the proposal that generated the ERC.

## ERC-20 Token Standard

This standard outlines: 1. What is a Token?<br>
Tokens can represent virtually anything in Ethereum: reputation points in an online platform, skills of a character in a game, lottery tickets, financial assets like a share in a company, a fiat currency like USD, an ounce of gold, and more...<br> 2. What is ERC-20?<br>
The ERC-20 introduces a standard for Fungible Tokens, in other words, they have a property that makes each Token be exactly the same (in type and value) as another Token. For example, an ERC-20 Token acts just like the ETH, meaning that 1 Token is and will always be equal to all the other Tokens.

The ERC-20 is a smart contract that **REPRESENTS** a token.

## Why make an ERC20?

1. Governance Tokens
2. Secure an underlying network
3. Create a synthetic asset
4. or really, anything else

## How do we build an ERC20?

All we need to do is build a smart contract that follows the ERC20 standard outlined in EIP-20 and implement the functions that are specified.
https://eips.ethereum.org/EIPS/eip-20

### Building Options for ERC20 Token Contract

As mentioned, we have the ability to manually create an ERC20 token smart contract by following the standard and implementing the functions and other standards that are outlined in the ERC and EIP. Doing this is correct, but is also time consuming.

There are providers out there that have already done this legwork to develop frameworks that we can leverage off. One of the most popular frameworks is **Open Zeppelin**, **_Solmate_** (which we used in the Smart Contract Raffle/Lottery) also contains a bunch of ERC/EIP contracts too.

## Open Zeppelin

Open Zeppelin is a framework that contains many useful ERC contracts, as well as an interactive window where you can build out ERC contracts to implement in your own projects.
This can save us time and effort in re-creating the ERC20 token smart contract by simply importing the OpenZeppelin ERC20 contract, and any other contracts that we require to work with our ERC20 token project.

### Installing Open Zeppelin

Following is copied from OpenZeppelin/openzeppelin-contracts

**Hardhat** (npm)

```shell
$ npm install @openzeppelin/contracts
```

**Foundry** (git)

**_Warning_**

When installing via git, it is a common error to use the master branch. This is a development branch that should be avoided in favor of tagged releases. The release process involves security measures that the master branch does not guarantee.

Foundry installs the latest version initially, but subsequent forge update commands will use the master branch.

**_WARNING_**

Add `--no-commit` at the end of the install statement if you have already an intialised git repository and do not want to add the folder to the git repository you have. You can add the downloadef folder to the .gitignore file to prevent the commiting of these folders

```shell
$ forge install OpenZeppelin/openzeppelin-contracts --no-commit
```

**_Installing with specified verison_**

```shell
$ forge install OpenZeppelin/openzeppelin-contracts@XX.XX.XX --no-commit
```

Where XX.XX.XX is the version information found on the github page.

**Remappings**

Add @openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/ in remappings.txt, setting.json or foundry.toml - whichever is appropriate to project.

### Usage

Once installed, you can use the contracts in the library by importing them:

    pragma solidity ^0.8.20;

    import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

    contract MyCollectible is ERC721 {
        constructor() ERC721("MyCollectible", "MCO") {
        }
    }
