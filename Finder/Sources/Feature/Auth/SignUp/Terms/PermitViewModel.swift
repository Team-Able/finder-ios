import Combine
import SwiftUI

class PermitViewModel: ObservableObject {
    @Published var isTermsAccepted: Bool = false
    @Published var isPrivacyPolicyAccepted: Bool = false
    @Published var isNotificationOptedIn: Bool = false

    var allSelected: Bool {
        isTermsAccepted && isPrivacyPolicyAccepted && isNotificationOptedIn
    }
    
    private var store: [AnyCancellable] = []

//    init() {
//        $allPermit
//            .sink { [weak self] newValue in
//                guard let self = self else { return }
//
//                if newValue && !allSelected {
//                    allSelected = true
//                    self.isTermsAccepted = true
//                    self.isPrivacyPolicyAccepted = true
//                    self.isNotificationOptedIn = true
//                } else if !newValue && allSelected { // 전체 동의가 체크되어 있는데 끈 경우
//                    allSelected = false
//                    self.isTermsAccepted = false
//                    self.isPrivacyPolicyAccepted = false
//                    self.isNotificationOptedIn = false
//                    
//                    (self.isTermsAccepted, self.isPrivacyPolicyAccepted, self.isNotificationOptedIn) = (false, false, false)
//                }
//            }
//            .store(in: &store)
//
//        Publishers.CombineLatest3($isTermsAccepted, $isPrivacyPolicyAccepted, $isNotificationOptedIn)
//            .sink { [weak self] fourteen, terms, info in
//                guard let self = self else { return }
//
//                if allSelected { // 모두 선택되었을 때,
//                    if self.allPermit {
//                        allSelected = false
//                        self.allPermit = false
//                    }
//                } else {
//                    if fourteen && terms && info {
//                        self.allPermit = true
//                    }
//                }
//            }
//            .store(in: &store)
//    }
}
