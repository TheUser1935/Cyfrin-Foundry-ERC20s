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

## What is the difference between a cryptocurrency and an ERC20 Token?

Cryptocurrency and ERC20 tokens are both types of digital assets, but they serve different purposes and have different characteristics:

**Cryptocurrency**:

Cryptocurrencies are digital or virtual currencies that use cryptography for security and operate on decentralized networks, typically based on blockchain technology.

Cryptocurrencies like Bitcoin, Ethereum, and Litecoin are designed to function as mediums of exchange, stores of value, or units of account.

They often have their own native blockchain networks, with specific protocols and consensus mechanisms governing their operation.

Cryptocurrencies are generally fungible, meaning each unit is interchangeable with any other unit of the same type and value.

They can be used for various purposes such as peer-to-peer transactions, remittances, investments, and as a hedge against inflation.

**ERC20 Tokens**:

ERC20 tokens are a specific type of digital asset that conforms to a set of standards outlined in the Ethereum Improvement Proposal 20 (ERC20).

They are created and hosted on the Ethereum blockchain, which is a decentralized platform for building smart contracts and decentralized applications (DApps).

ERC20 tokens can represent a wide range of assets, including cryptocurrencies, digital securities, utility tokens, and even real-world assets like real estate or artwork.

These tokens are programmable, allowing developers to define custom functionalities and features within the token's smart contract code.
ERC20 tokens are typically used for crowdfunding through Initial Coin Offerings (ICOs), creating decentralized finance (DeFi) protocols, powering DApps, and tokenizing assets.

Unlike cryptocurrencies like Bitcoin or Ethereum, ERC20 tokens are not native to their own blockchain; instead, they are deployed on the Ethereum network as smart contracts.

ERC20 tokens can be both fungible (e.g., representing currencies) and non-fungible (e.g., representing unique assets or collectibles), depending on their implementation.

**Summary**

In summary, while both cryptocurrencies and ERC20 tokens are digital assets, cryptocurrencies typically refer to native digital currencies that operate on their own blockchain networks, while ERC20 tokens are programmable assets built on the Ethereum blockchain, representing a wide variety of assets and functionalities.

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

## Deploy Script and How an ERC20 Token Contract Simplifies Deployment

In other projects covered in the course, we have used a HelperConfig.s.sol file to allow our Deploy.s.sol script to make changes to required variables, structs, other external contracts, etc, etc.

However, since we are creating a standardised ERC20 Token contract, we don't need any chain specific logic as it is simply the same across all chains. If we were building a bigger project that utilised the ERC20 token contract, then chain specific logic exisitng in a HelperConfig script would be beneficial.

We could have logic in either the Deploy script, or a HelperConfig script to set a deployer key so we can programmatically deploy our token between different chains - e.g Anvil, Sepolia.

Remembering that the way we can access uint env variables from .env is:

`vm.envUint("NAME_OF_ENV_VARIABLE")`
