#!/bin/bash

scriptpath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
libdir=$scriptpath/../blockchain-crypto-mpc
export LD_LIBRARY_PATH=$libdir
fakesig=false

usage() {
  echo "verify <OPTION> [message to sign]"
  echo "OPTIONS"
  echo "  -h                    Print this message"
  echo
  echo "example: verify pay carol $5"
}

OPTS=`getopt -l help fh "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "$OPTS"

while [ "$1" != -- ]
do
  case $1 in
    -h|--help)
      shift
      usage
      exit 0
      ;;
  esac
done

shift # removing '--' from arg list

message=$@

# crypto-lib wants 32 digit hex value - assuming md5
cksum <<< $message | cut -f 1 -d ' ' > $scriptpath/to-ver.dat

# pull from chain
node $scriptpath/../chain-bridge/app.js -g $scriptpath/sig.hex

# reverse hex back to binary
xxd -r -p $scriptpath/sig.hex $scriptpath/sig.bin

# verify
cd $scriptpath
echo "Verifying..."
python $libdir/python/mpc_demo.py --type ECDSA --command verify \
    --in_file $scriptpath/../bob/key_share_bob.bin \
    --out_file $scriptpath/sig.bin \
    --data_file $scriptpath/to-ver.dat \
    --host localhost
    #--out_file $scriptpath/../bob/ECDSA_signature_1.dat \
cd -
