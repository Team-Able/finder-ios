import SwiftUI
import UIKit
import KakaoMapsSDK

struct MyLocationMapView: UIViewRepresentable {
    @Binding var draw: Bool
    @ObservedObject var locationManager: LocationManager // LocationManager 받기
    
    func makeUIView(context: Self.Context) -> KMViewContainer {
        let view: KMViewContainer = KMViewContainer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        context.coordinator.createController(view)
        
        return view
    }

    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        if draw {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if context.coordinator.controller?.isEnginePrepared == false {
                    context.coordinator.controller?.prepareEngine()
                }
                
                if context.coordinator.controller?.isEngineActive == false {
                    context.coordinator.controller?.activateEngine()
                }
            }
        } else {
            context.coordinator.controller?.pauseEngine()
            context.coordinator.controller?.resetEngine()
        }
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator(locationManager: locationManager) // LocationManager 전달
    }
}

import Foundation
import UIKit
import KakaoMapsSDK_SPM

class KakaoMapCoordinator: NSObject, MapControllerDelegate {
    var controller: KMController?
    var container: KMViewContainer?
    var first: Bool
    var auth: Bool
    
    @ObservedObject var locationManager: LocationManager // LocationManager 받아오기
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.first = true
        self.auth = false
        super.init()
    }
    
    func createController(_ view: KMViewContainer) {
        container = view
        controller = KMController(viewContainer: view)
        controller?.delegate = self
    }
    
    func addViews() {
        guard let location = locationManager.userLocation else { return }
        let defaultPosition: MapPoint = MapPoint(longitude: location.longitude, latitude: location.latitude)
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
        controller?.addView(mapviewInfo)
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        print("Map view successfully added")
        if let view = controller?.getView("mapview") as? KakaoMap {
            view.viewRect = container!.bounds
            if first {
                moveToPosition()
                first = false
            }
        }
    }
    
    func containerDidResized(_ size: CGSize) {
        if let mapView = controller?.getView("mapview") as? KakaoMap {
            mapView.viewRect = CGRect(origin: .zero, size: size)
        }
    }
    
    func authenticationSucceeded() {
        auth = true
    }
    
    func moveToPosition() {
        guard let location = locationManager.userLocation else { return }
        if let mapView = controller?.getView("mapview") as? KakaoMap {
            let cameraUpdate = CameraUpdate.make(target: MapPoint(longitude: location.longitude, latitude: location.latitude), mapView: mapView)
            mapView.moveCamera(cameraUpdate)
        }
    }
}

