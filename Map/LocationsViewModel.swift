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
    
    @Published var sheetLocation: Location? = nil
    
    // Show list of Location
    @Published var isShowLocationList: Bool = false
    
    @Published var isMenuButton: Bool = false
    
    @Published var isSlideFromLeadingToTrailing: Bool = false
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
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
        
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else { return }
        
        guard let newLocationIndex = locations.firstIndex(where: { $0 == location }) else { return }
        
        if isMenuButton {
            if currentIndex < newLocationIndex {
                isSlideFromLeadingToTrailing = false
            }else{
                isSlideFromLeadingToTrailing = true
            }
        }

        withAnimation(.easeInOut) {
            mapLocation = location
            isShowLocationList = false
        }
    }
    
    func nextButtonPressed() {
            
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else { return }
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else {
            
            guard let firstLocation = locations.first else { return }
            
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
        
    }
    
    func backButtonPressed() {
        
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else { return }
        
        let backIndex = currentIndex - 1
        
        guard locations.indices.contains(backIndex) else {
            
            guard let lastLocation = locations.last else { return }
            
            showNextLocation(location: lastLocation)
            return
        }
        
        let backLocation = locations[backIndex]
        showNextLocation(location: backLocation)
        
        
    }
    
    
}
