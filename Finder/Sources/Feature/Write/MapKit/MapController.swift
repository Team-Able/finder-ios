import UIKit
import MapKit

class MapController: UIViewController, ObservableObject {

    private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MKMapView 초기화 및 뷰에 추가
        mapView = MKMapView(frame: self.view.bounds)
        self.view.addSubview(mapView)
        
        // 지도의 중심 좌표와 줌 레벨 설정
        let center = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco, CA
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco, CA
        annotation.title = "San Francisco"
        annotation.subtitle = "CA"
        mapView.addAnnotation(annotation)
    }
    
    func searchLocation(named name: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = name

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // 검색 결과에서 첫 번째 위치를 지도의 중심으로 설정
            let firstLocation = response.mapItems.first?.placemark.coordinate
            if let location = firstLocation {
                let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}
