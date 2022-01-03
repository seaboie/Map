//
//  LocationsView.swift
//  Map
//
//  Created by Kritbovorn Taweeyossak on 1/1/2565 BE.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        
        ZStack {
            
            mapLayer
                .ignoresSafeArea()
            
            VStack() {
                
                header
                    .padding()
                
                Spacer()
                
                locationPreviewStack
                
            }
        }
    }
}

extension LocationsView {
    
    private var header: some View {
        
        VStack() {
            
            Button {
                vm.toggleLocationList()
                vm.isMenuButton = true
            } label: {
                
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(Font.title2)
                    .fontWeight(Font.Weight.black)
                    .foregroundColor(Color.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.mapLocation)
                    .overlay(alignment: Alignment.leading) {
                        Image(systemName: "arrow.down")
                            .font(Font.headline)
                            .foregroundColor(Color.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.isShowLocationList ? 180 : 0))
                    }
                
            }

            if vm.isShowLocationList {
                
                LocationsListView()
                
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        
    }
    
    private var mapLayer: some View {
        
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.6)
                    .shadow(radius: 2)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
        
    }
    
    private var locationPreviewStack: some View {
        
        ZStack {
            
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.6), radius: 5)
                        // Animation Transition
                        .transition(AnyTransition.asymmetric(insertion: vm.isSlideFromLeadingToTrailing ? .move(edge: .leading) : .move(edge: .trailing), removal: vm.isSlideFromLeadingToTrailing ? .move(edge: .trailing) : .move(edge: .leading)))
                }
            }
        }
        
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
