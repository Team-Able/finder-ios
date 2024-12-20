import SwiftUI
import KakaoMapsSDK

@main
struct FinderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("accessToken")
    private var accessToken: String?
    
    var body: some Scene {
        WindowGroup {
            if accessToken == nil {
                LoginView()
            } else {
                CustomTabView()
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String {
            SDKInitializer.InitSDK(appKey: kakaoAppKey)
            print("키불러오기 성공")
        } else {
            fatalError("Kakao App Key is missing in Info.plist")
        }
        return true
    }
}

