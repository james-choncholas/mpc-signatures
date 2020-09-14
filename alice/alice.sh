#!/bin/bash

scriptpath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
libdir=$scriptpath/../blockchain-crypto-mpc
export LD_LIBRARY_PATH=$libdir
fakesig=false

usage() {
  echo "alice <OPTION> [message to sign]"
  echo "OPTIONS"
  echo "  -h                    Print this message"
  echo "  -f                    Fake the signature"
  echo
  echo "example: alice -f pay carol $5"
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
if [ ! -f $scriptpath/key_share_alice.bin ]; then
    echo "Generating Alice's ECDSA key shard..."
    python $libdir/python/mpc_demo.py --out_file $scriptpath/key_share_alice.bin --server
    sleep 1 # wait for alice to die
fi

# Decide if we are faking a signature
if $fakesig ; then
    keyfile=$scriptpath/fake-key.bin
else
    keyfile=$scriptpath/key_share_alice.bin
fi

# Now sign
cd $scriptpath
echo "Signing..."
python $libdir/python/mpc_demo.py --in_file $keyfile --data_file $scriptpath/to-sign.dat --server
cd -

# Bob (client) uploads for us. This is okay because bob signed and wants the sig visible just as much as us.
