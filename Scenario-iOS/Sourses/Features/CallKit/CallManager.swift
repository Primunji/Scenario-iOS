import CallKit
import Combine

class CallManager: NSObject, CXProviderDelegate, ObservableObject {
    var provider: CXProvider!
    var callController = CXCallController()
    
    static let shared = CallManager()
    var callState = false;
    
    
    override init() {
        super.init()
        let providerConfig = CXProviderConfiguration(localizedName: "MyApp")
        providerConfig.supportsVideo = false
        providerConfig.maximumCallsPerCallGroup = 1
        providerConfig.supportedHandleTypes = [.generic]
        providerConfig.includesCallsInRecents = false

        provider = CXProvider(configuration: providerConfig)
        provider.setDelegate(self, queue: nil)
    }

    func reportIncomingCall(uuid: UUID, handle: String) {
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: handle)
        update.hasVideo = false
        
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            if let error = error {
                print("Failed to report incoming call: \(error.localizedDescription)")
            }
        }
    }

    func startCall(handle: String) {
        let uuid = UUID()
        let handle = CXHandle(type: .generic, value: handle)
        let action = CXStartCallAction(call: uuid, handle: handle)
        let transaction = CXTransaction(action: action)

        action.isVideo = false
    
        callController.request(transaction) { error in
            if let error = error {
                print("Error starting call: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.callState = true // ContentView 업데이트
                }
                CallManager.shared.provider.reportOutgoingCall(with: uuid, connectedAt: Date())
            }
        }
    }


    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()

    }

//    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
//        Task {
//        
//            try await RoomView.shared.getRoom().disconnect()
//            action.fulfill()
//        }
//    }
//
//    
//    
//    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
//        Task {
//            do {
//                try await RoomView.shared.getRoom().localParticipant.setMicrophone(enabled: true)
//            } catch {
//                print("Error disconnecting: \(error.localizedDescription)")
//            }
//            
//            
//            action.fulfill()
//        }
//    }

    
    func providerDidReset(_ provider: CXProvider) {
        Task {
            do {
                DispatchQueue.main.async {
                    self.callState = false // ContentView 업데이트
                }
            } catch {
                print("Error disconnecting during reset: \(error.localizedDescription)")
            }
        }
    }
    
    
}
