//
//  LocationsListView.swift
//  Map
//
//  Created by Kritbovorn Taweeyossak on 1/1/2565 BE.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        
        List {
            ForEach(vm.locations) { location in
                
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 5)
                .listRowBackground(Color.clear)

            }
        }
        .listStyle(PlainListStyle())
    }
}

extension LocationsListView {
    
    private func listRowView(location: Location) -> some View {
        
        HStack(spacing: 18) {
            
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55, alignment: .center)
                    .cornerRadius(55)
            }
            
            VStack(alignment: .leading) {
                
                Text(location.name)
                    .font(Font.headline)
                
                Text(location.cityName)
                    .font(Font.subheadline)
                    .fontWeight(Font.Weight.bold)
                    .foregroundColor(Color.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}
