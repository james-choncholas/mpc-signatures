# Background

Blockchain is about data security by making the data recorded on the chain immutable. As part of the blockchain security model, all transactions are signed so that the submitter’s identity is always securely tied to the transaction.

In the Ethereum programming model, the signing keys are located in a component typically referred to as a Wallet. A wallet holds one or more signing keys used to sign and submit transactions.

For most decentralized applications, a transaction gets signed by a single key and the owner of the single signing key is considered the single party responsible for signing off on the transaction execution, whether that single party is an individual or an organization.

In some use cases, on the other hand, multiple parties want to jointly sign off on a transaction such that only after all the parties have approved with their own signature, the transaction is not considered valid and will be rejected. For example, if a payment transaction amount surpasses a threshold, both of the company’s CFO and CEO need to sign off before the payment can be made. This prevents a rogue employee from submitting transactions for their personal gains or out of other malicious intents. Another example is a joint bid to a large contract that must be signed off by all the participating organizations before it can be submitted.

The above is a pretty popular pattern that can be implemented with existing techniques called multi-sig transactions. Pioneered by the Bitcoin community, which since has been adopted by other blockchain communities including Ethereum, this includes first deploying a signature verification logic (either in Bitcoin scripts or smart contracts) that requires signatures from multiple submitters on the same transaction payload, before allowing that payload to be submitted for execution.

Using a multi-sig signing scheme means the signatures from each individual signer are disclosed in the blockchain. For instance, if the multi-sig scheme is set up to be 3 out of 5 signatures, then for every valid transaction the identities of the 3 signers are always known by the participants of the blockchain network. This may not work in some scenarios where the intention is to protect the identities of the individual signers and only disclose the final “combined” signature.

This is where a signing scheme based on Secure Multiparty Computation (MPC) comes in. MPC based signing allows a single signing key to be “broken apart” into N parts and as long as a threshold of M parts are able to participate in the computation, the resulting signature is always the same. This enables the distribution of approval among multiple parties while keeping the identities of the signing parties hidden.

# The Challenge

We would like you to design and implement a multi party transaction submission application using MPC.

The application should have the following parts:

    3-node blockchain: we’d like to ask you to set up a local blockchain using geth running Proof-of-Authority consensus algorithm, here’s a good tutorial https://hackernoon.com/setup-your-own-private-proof-of-authority-ethereum-network-with-geth-9a0a3750cda8
    Deploy a simple smart contract to the blockchain. This smart contract will be the target of the application to submit transactions. Feel free to use any contracts available in the public space, such as the one in Kaleido’s sample repository: https://github.com/kaleido-io/kaleido-js/tree/master/deploy-transact. You can also use this sample application to deploy the contract
    Write a program that does the MPC computation to sign a transaction among multiple parties. It should be written in such a way that given different file based configurations it will assume the identity of a different player in the computation scheme
    Finally, write a simple client program that coordinates calling the multiple signing programs for MPC and collect the final result, then submit it to the blockchain by calling the smart contract deployed above. This will take some web3 programming similar to what you see in the deploy-transact/test.js application above.

For the program in step 3, feel free to use your personal judgement which MPC library to use. As a reference here’s an authoritative source of current MPC libraries: https://github.com/MPC-SoK/frameworks. But if you think another library outside of this list is more appropriate, free free to use it but please give a good reason (like “my professor recommends it”).

Ideally the program from step 3 should be a web application that can be deployed locally multiple times, each with their own configurations assuming their individual MPC identity. Then the client program from step 4 will just call them via HTTP.

Alternatively, it’s also acceptable if the signing program are simple executables that can be called from command line. And the client program can use shell execution to invoke them and collect results.

For the design of the overall application, feel free to tap into the wisdom of your professors or your advisor. But please do the coding part independently.

# Output

Please save your work in a personal github repository. It can be public (ideally) or private (if necessary for your circumstances). If you choose to use a private repo, please add the following github IDs to have access:

    jimthematrix
    peterbroadhurst
    vdamle

Besides the code, the repository should have a README that describes the different pieces of the application, and how to run it.

Finally, we will invite you for a playback of the finished product to the Kaleido founding team. So any materials like .ppt’s that help with illustrating the thinking behind the design and the architecture will be useful for an effective presentation.


