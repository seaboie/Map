//
//  LocationsViewModel.swift
//  Map
//
//  Created by Kritbovorn Taweeyossak on 1/1/2565 BE.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    // Show list of Location
    @Published var isShowLocationList: Bool = false
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    func updateMapRegion(location: Location) {
        
        withAnimation(Animation.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
        
    }
    
    func toggleLocationList() {
        
        withAnimation(.easeInOut) {
            isShowLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        
        withAnimation(.easeInOut) {
            mapLocation = location
            isShowLocationList = false
        }
    }
    
    
}
