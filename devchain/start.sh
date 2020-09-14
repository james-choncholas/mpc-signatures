#!/bin/bash
scriptpath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bootnode -nodekey $scriptpath/boot.key -verbosity 9 -addr :30310 &

sleep 10 # let this guy start up

# to clean a node
# rm -r node1/geth/
# geth --datadir node1/ init devchain.json

geth --datadir $scriptpath/node1/ \
    --unlock '0xc54bf090c0338e574E4aC8768c5441a677CD8D7B' \
    --syncmode 'full' \
    --port 30311 \
    --rpc --rpcaddr 'localhost' --rpcport 8501 --rpcapi 'personal,db,eth,net,web3,txpool,miner' \
    --bootnodes 'enode://3fdef815a2316b640904ed26b460a3c58544659153e69bc803d44a4fdd860b0e44ee05510831386c7231e420dd62de61ef66ac9f6f5d6089716ed04f5a79fc00@127.0.0.1:30310' \
    --networkid 666 \
    --gasprice '1' \
    --password $scriptpath/password.txt \
    --allow-insecure-unlock \
    --targetgaslimit 94000000 \
    --mine &

sleep 10 # let this guy mine a block real quick...


geth --datadir $scriptpath/node2/ \
    --unlock '0x03Fa48EA9B50765B10829aAfAADcE48d8317AA44' \
    --syncmode 'full' \
    --port 30312 \
    --rpc --rpcaddr 'localhost' --rpcport 8502 --rpcapi 'personal,db,eth,net,web3,txpool,miner' \
    --bootnodes 'enode://3fdef815a2316b640904ed26b460a3c58544659153e69bc803d44a4fdd860b0e44ee05510831386c7231e420dd62de61ef66ac9f6f5d6089716ed04f5a79fc00@127.0.0.1:30310' \
    --networkid 666 \
    --gasprice '1' \
    --password $scriptpath/password.txt \
    --allow-insecure-unlock \
    --targetgaslimit 94000000 \
    --mine &

sleep 10 # let the previous two guys mine a block real quick...


geth --datadir $scriptpath/node3/ \
    --unlock '0x2AE750877B045802b2A2b764eC9476E9490E4cBC' \
    --syncmode 'full' \
    --port 30313 \
    --rpc --rpcaddr 'localhost' --rpcport 8503 --rpcapi 'personal,db,eth,net,web3,txpool,miner' \
    --bootnodes 'enode://3fdef815a2316b640904ed26b460a3c58544659153e69bc803d44a4fdd860b0e44ee05510831386c7231e420dd62de61ef66ac9f6f5d6089716ed04f5a79fc00@127.0.0.1:30310' \
    --networkid 666 \
    --gasprice '1' \
    --password $scriptpath/password.txt \
    --allow-insecure-unlock \
    --targetgaslimit 94000000 \
    --mine &
