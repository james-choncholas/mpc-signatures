#!/bin/bash
scriptpath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rm -r $scriptpath/node1/geth/
rm -r $scriptpath/node2/geth/
rm -r $scriptpath/node3/geth/

geth --datadir $scriptpath/node1/ init $scriptpath/devchain.json
geth --datadir $scriptpath/node2/ init $scriptpath/devchain.json
geth --datadir $scriptpath/node3/ init $scriptpath/devchain.json
