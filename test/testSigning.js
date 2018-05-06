var DRM = artifacts.require('DRM')


contract('DRM', (accounts) => {
    var address = accounts[0]

    it('ecrecover result matches address', async function() {
        var instance = await DRM.deployed()
        var msg = 'hello'
        var h = web3.sha3(msg)
        var sig = web3.eth.sign(address, h).slice(2)
        var r = `0x${sig.slice(0, 64)}`
        var s = `0x${sig.slice(64, 128)}`
        var v = web3.toDecimal(sig.slice(128, 130)) + 27

        var result = await instance.testRecovery.call(h, v, r, s)
        console.log(result)
    })
})