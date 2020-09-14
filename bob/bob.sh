#!/bin/bash

scriptpath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
libdir=$scriptpath/../blockchain-crypto-mpc
export LD_LIBRARY_PATH=$libdir
fakesig=false

usage() {
  echo "bob <OPTION> [message to sign]"
  echo "OPTIONS"
  echo "  -h                    Print this message"
  echo "  -f                    Fake the signature"
  echo
  echo "example: bob -f pay carol $5"
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
    -f)
      shift
      fakesig=true
      ;;
  esac
done

shift # removing '--' from arg list

message=$@

# crypto-lib wants 32 digit hex value - assuming md5
cksum <<< $message | cut -f 1 -d ' ' > $scriptpath/to-sign.dat

# First generate keys
if [ ! -f $scriptpath/key_share_bob.bin ]; then
    echo "Generating Bob's ECDSA key shard..."
    python $libdir/python/mpc_demo.py --type ECDSA --command generate --out_file $scriptpath/key_share_bob.bin --host localhost
    sleep 5 # wait for alice and bob to die before trying to reconnect
fi

# Decide if we are faking a signature
if $fakesig ; then
    keyfile=$scriptpath/fake-key.bin
else
    keyfile=$scriptpath/key_share_bob.bin
fi

# Now sign
cd $scriptpath
echo "Signing..."
python $libdir/python/mpc_demo.py --type ECDSA --command sign --in_file $keyfile --data_file $scriptpath/to-sign.dat --host localhost
cd -

# upload to chain
node $scriptpath/../chain-bridge/app.js -s $(xxd -p $scriptpath/ECDSA_signature_1.dat | tr -d '\n')
