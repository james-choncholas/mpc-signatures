# Interview Challange
See [challenge.md](challenge.md) for problem definition.

The solution presented here can be broken into four pieces.
First, the devchain/ directory contains the configuration and setup
to run a private, local blockchain with three participating nodes.
Next a smart contract resides in store-contract/ as a truffle project.
This contract is deployed to the local chain.
Lindell's blockchain-crypto-mpc library is used to run EDDSA
signatures via MPC for two parties.
This process is managed by coordinator.sh in coordinator/.
Finally, the coordinator will upload the signature to the deployed
contract via the web3 client in the chain-bridge/ directory.

# Environment
The following build instructions are for Ubuntu 18.04LTS but will likely work
with little modification on other debian-based operating systems.

# First Run Setup
0) Ensure submodules have been pulled.
```
git submodule init
```

1) Install crypto library dependencies and build.
```
make deps
```

2) Follow the instructions in devchain/README.md.

3) Deploy the truffle contract.
```
cd store-contract
truffle deploy --network devchain
```

4) Install node packages for chain-bridge
```
cd chain-bridge
npm install
```

# Run
```
./devchain/start.sh
./alice/alice.sh pay carol $5
./bob/bob.sh pay carol $5
```
Note to stop the devchain run `./devchain/stop.sh`

Note: both alice and bob have the ability to fake a signature using an incorrect key shard.
Passing the `-f` flag to the script enables this behavior.
Unfortunately the blockchain-crypto-mpc library crashes when doing this.

# Verify Signature
```
./verify/verify.sh pay carol $5
```

The verify script will pull the signature from the chain and verify with the message passed
in as an argument.
