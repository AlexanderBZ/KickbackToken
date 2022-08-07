import KickbackToken from 0x01
import FungibleToken from 0x02

pub fun main(account: Address) {
  let publicVault = getAccount(account).getCapability(/public/kickbackTokenBalance)
                      .borrow<&KickbackToken.Vault{FungibleToken.Balance}>() 
                      ?? panic("Could not borrow the public vault")
  log(publicVault.balance)
}