@testable import Whollet
import Foundation
import ICONKit

final class MockWalletRepository: WalletRepository {
    var isCreateWalletCalled = false
    var isLoadWalletCalled = false
    var isGetICXBalanceCalled = false
    var isSendTransactionCalled = false
    var isGetTransactionResultCalled = false
    
    var completeSendTransactionClosure: ((String?, Error?) -> ())!
    var completeSendTransaction = "mockHash"
    
    func createWallet() -> Wallet {
        isCreateWalletCalled = true
        return Wallet(privateKey: nil)
    }
    
    func getWalletFromPrivateKey(privateKey: String) -> Wallet {
        isLoadWalletCalled = true
        return Wallet(privateKey: nil)
    }
    
    func getIcxBalance(address: String) -> String {
        isGetICXBalanceCalled = true
        return ""
    }
    
    func sendTransaction(receivingAddress: String, amount: Double, wallet: Wallet, completion: @escaping (String?, Error?) -> Void) {
        isSendTransactionCalled = true
        completeSendTransactionClosure = completion
    }
    
    func sendTransactionSuccess() {
        completeSendTransactionClosure(completeSendTransaction, nil)
    }
    
    func sendTransactionFail(error: APIError?) {
        completeSendTransactionClosure(nil, error)
    }
    
    func getTransaction(txHash: String) -> Response.TransactionByHashResult? {
        isGetTransactionResultCalled = true
        return nil
    }
}
