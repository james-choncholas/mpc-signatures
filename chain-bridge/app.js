const fs = require('fs');
const yargs = require('yargs');
const fetch = require("node-fetch");
const url = 'http://localhost:8501';
const Web3 = require('web3');

const contract = require("@truffle/contract");
const StorageArtifacts = require('./Store.json');

var web3;
var Storage;
var storageInstance;

async function start(get, val) {
    console.log('looking for local node...');
    await fetch(url).catch(err => {
        console.error(err);
        throw Error('local node not found');
    });

    console.log('local node active. connecting to node...');
    var provider = new Web3.providers.HttpProvider(url);
    web3 = new Web3(provider);
    //console.log(await web3.eth.net.getId());

    console.log('connected to local node. finding contracts...');

    Storage = contract(StorageArtifacts);
    Storage.setProvider(provider);
    storageInstance =  await Storage.deployed();
    console.log("storage contract address: " + storageInstance.address);

    let owner = (await web3.eth.personal.getAccounts())[0];

    if (get == "") {
        let s = await storageInstance.set(val, {from: owner})
            .catch(function(e) {return e;});
        console.log('Storing value: ' + val);
        console.log(s);
    } else {
        let v = await storageInstance.get.call({from: owner})
            .catch(function(e) {return e;});
        console.log('got value: ' + v);
        fs.writeFile(get, v, function (err) {
            if (err) return console.log(err);
        });
    }
}

const argv = yargs
    .option('s', {
            alias : 'to-store',
            describe: 'Value to store on-chain',
            type: 'string', /* array | boolean | string */
            nargs: 1,
            default: "",
    })
    .option('g', {
            alias : 'get',
            describe: 'Get the value on chain and write to file',
            type: 'string', /* array | boolean | string */
            nargs: 1,
            default: "",
    })
    .alias('h', 'help')
    .help('help')
    .showHelpOnFail(true, "Specify --help for available options")
    .argv;

start(argv.g, argv.s);
