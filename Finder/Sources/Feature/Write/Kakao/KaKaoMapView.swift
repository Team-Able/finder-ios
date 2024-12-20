//import Foundation
//import SwiftUI
//import KakaoMapsSDK
//
//struct KaKaoMapView: UIViewRepresentable {
//    @Binding var draw: Bool
//    
//    func makeUIView(context: Context) -> KMViewContainer {
//        let view: KMViewContainer = KMViewContainer()
//        view.sizeToFit()
//        context.coordinator.createController(view)
//        context.coordinator.controller?.prepareEngine()
//        
//        return view
//    }
//    
//    func updateUIView(_ uiView: KMViewContainer, context: Context) {
//        if draw {
//            context.coordinator.controller?.activateEngine()
//        } else {
//            context.coordinator.controller?.resetEngine()
//        }
//    }
//    
//    func makeCoordinator() -> KMCoordinator {
//        return KMCoordinator()
//    }
//    
//    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KMCoordinator) {
//        
//    }
//    
//    class KMCoordinator: NSObject, MapControllerDelegate {
//        var controller: KMController?
//        var first: Bool
//        
//        override init() {
//            first = true
//            super.init()
//        }
//        
//        func createController(_ view: KMViewContainer) {
//            controller = KMController(viewContainer: view)
//            controller?.delegate = self
//        }
//        
//        func addViews() {
//            let defaultPosition: MapPoint = MapPoint(longitude: 14135167.020272, latitude: 4518393.389136)
//            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
//            
//            controller?.addView(mapviewInfo)
//        }
//        
//        func addViewSucceeded(_ viewName: String, viewInfoName: String) {
//            print("OK")
//        }
//        
//        func addViewFailed(_ viewName: String, viewInfoName: String) {
//            print("Failed")
//        }
//        
//        func authenticationSucceeded() {
//            print("auth succeed!!")
//        }
//        
//        func authenticationFailed(_ errorCode: Int, desc: String) {
//            print("auth failed")
//            print("error code: \(errorCode)")
//            print(desc)
////            print(controller?.getStateDescMessage())
//        }
//        
//        func containerDidResized(_ size: CGSize) {
//            let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
//            mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
//            
//            if first {
//                let cameraUpdate: CameraUpdate = CameraUpdate.make(
//                    target: MapPoint(longitude: 14135167.020272, latitude: 4518393.389136),
//                    zoomLevel: 10,
//                    mapView: mapView!
//                )
//                mapView?.moveCamera(cameraUpdate)
//                first = false
//            }
//        }
//    }
//}
