import Foundation
import ICONKit

enum WalletState {
    case initial
    case inProgress
    case loadSuccess
}

final class WalletViewModel: NSObject {
    private var createWalletUseCase: CreateWalletUseCase!
    private var loadWalletUseCase: LoadWalletUseCase!
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    private(set) var bsWalletState: BehaviorSubject<WalletState> = BehaviorSubject(nil)
    private var wallet: Wallet!
    
    override init() {
        super.init()
        bsWalletState.add(.initial)
        self.createWalletUseCase = CreateWalletUseCase(walletRepository: WalletRepositoryImpl())
        self.loadWalletUseCase = LoadWalletUseCase(walletRepository: WalletRepositoryImpl())
    }
    
    func createWallet() {
        bsWalletState.add(.inProgress)
        wallet = createWalletUseCase.create()
        UIPasteboard.general.string = wallet.key.privateKey.hexEncoded
        appDelegate?.wallet = wallet
        bsWalletState.add(.loadSuccess)
    }
    
    func loadWallet(_ privateKey: String) {
        bsWalletState.add(.inProgress)
        wallet = loadWalletUseCase.load(key: privateKey)
        appDelegate?.wallet = wallet
        bsWalletState.add(.loadSuccess)
    }
}
