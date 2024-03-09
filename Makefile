-include .env

fb:;	forge build

ft :; forge test 

fs :; forge snapshot

format :; forge fmt

# Clean the repo
clean  :; forge clean

dp-sepolia:
	forge script script/DeployMyToken.s.sol:DeployMyToken --rpc-url $(SEPOLIA_ALCHEMY_RPC_URL) --private-key $(SEPOLIA_METAMASK_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""



NETWORK_ARGS := --rpc-url $(ANVIL_RPC_URL) --private-key $(ANVIL_0_PRIVATE_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(SEPOLIA_METAMASK_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

# Update Dependencies
update:; forge update

deploy:
	@forge script script/DeployMyToken.s.sol:DeployMyToken $(NETWORK_ARGS)

