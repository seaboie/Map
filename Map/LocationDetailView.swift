//
//  LocationDetailView.swift
//  Map
//
//  Created by Kritbovorn Taweeyossak on 3/1/2565 BE.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    let location: Location
    @EnvironmentObject private var vm: LocationsViewModel
    
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                imageSlider
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    titleSection
                    
                    Divider()
                    
                    descriptionAndLinkSection
                    
                    Divider()
                    
                    mapLayer
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            closeButton
        }
    }
}

extension LocationDetailView {
    
    private var imageSlider: some View {
        
        TabView {
            ForEach(location.imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.size.width)
                    .clipped()
                    
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
        
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
        
    }
    
    private var descriptionAndLinkSection: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(Color.blue)
            }
            
        }
    }
    
    private var mapLayer: some View {
        
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))),
            annotationItems: [ location ]) { location in
            
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .shadow(radius: 10)
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(20)
        
    }
    
    private var closeButton: some View {
        
        Button {
            //
            vm.sheetLocation = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color.secondary)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .padding()
                .shadow(radius: 5)
            
        }

    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}
