import KickbackToken from 0x01
import FungibleToken from 0x02

transaction {
    prepare(acct: AuthAccount) {
        acct.save(<- KickbackToken.createEmptyVault(), to: /storage/kickbackTokenVault)
        acct.link<&KickbackToken.Vault{FungibleToken.Balance, FungibleToken.Receiver}>(/public/kickbackTokenBalance, target: /storage/kickbackTokenVault)
    }

    execute {
        log("I saved my own personal vault")
    }
}