//
//  MapView.swift
//  Finder
//
//  Created by dgsw30 on 10/16/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    @State private var locationManager = CLLocationManager()
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .onAppear {
                showMyregion()
            }
    }
    func showMyregion() {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        let latitude = manager.location?.coordinate.latitude
        let longitude = manager.location?.coordinate.longitude
        
        if let location = locationManager.location {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        } else {
            print("실패")
        }
    }
}

#Preview {
    MapView()
}
