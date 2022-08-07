import KickbackToken from 0x01
import FungibleToken from 0x02

transaction(receiverAccount: Address, amount: UFix64) {
    prepare(acct: AuthAccount) {
        let signerVault = acct.borrow<&KickbackToken.Vault>(from: /storage/kickbackTokenVault) 
                            ?? panic("Couldn't get the signer's Vault")
        let receiverVault = getAccount(receiverAccount).getCapability(/public/kickbackTokenBalance)
                                .borrow<&KickbackToken.Vault{FungibleToken.Receiver}>()
                                ?? panic("Couldn't get the public Vault")
        receiverVault.deposit(from: <- signerVault.withdraw(amount: amount))
    }

    execute {
        log("Transferred KickbackToken")
    }
}