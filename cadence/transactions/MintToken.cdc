import KickbackToken from 0x01
import FungibleToken from 0x02

transaction(receiverAccount: Address) {
  prepare(acct: AuthAccount) {
    let administrator = acct.borrow<&KickbackToken.Administrator>(from: /storage/kickbackTokenAdmin) ?? panic("We could not borrow the Admin resource")
    let minter <- administrator.createNewMinter(allowedAmount: UFix64(40))
    let newVault <- minter.mintTokens(amount: 20.0)

    let receiverVault = getAccount(receiverAccount).getCapability(/public/kickbackTokenBalance)
                          .borrow<&KickbackToken.Vault{FungibleToken.Receiver}>() 
                          ?? panic("Couldn't get the public vault")

    receiverVault.deposit(from: <- newVault)

    destroy minter
  }

  execute {
    log("succesfully deposited tokens to receiver account")
  }
}