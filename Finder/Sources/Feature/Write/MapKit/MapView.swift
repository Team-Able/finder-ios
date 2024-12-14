import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var region: MKCoordinateRegion
    var latitude: Binding<Double>
    var longitude: Binding<Double>

    init(latitude: Binding<Double>, longitude: Binding<Double>, initialLatitude: Double, initialLongitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self._region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: initialLatitude, longitude: initialLongitude),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ))
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: false)
            .ignoresSafeArea()
    }
}

#Preview {
    MapView(latitude: .constant(37.7749), longitude: .constant(-122.4194), initialLatitude: 37.7749, initialLongitude: -122.4194)
}
