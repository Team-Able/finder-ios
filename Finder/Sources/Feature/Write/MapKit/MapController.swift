import UIKit
import MapKit

class MapController: UIViewController, ObservableObject {

    private var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView(frame: self.view.bounds)
        self.view.addSubview(mapView)
         
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

            let firstLocation = response.mapItems.first?.placemark.coordinate
            if let location = firstLocation {
                let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}
