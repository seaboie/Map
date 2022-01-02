//
//  LocationPreviewView.swift
//  Map
//
//  Created by Kritbovorn Taweeyossak on 2/1/2565 BE.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let location: Location
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 6) {
            
            VStack(alignment: .leading, spacing: 16) {
                
                imageSection
                
                titleSection
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                
                learnMoreButton
                
                HStack {
                    
                    backButton
                    
                    nextButton

                }
                .font(.headline)
                .buttonStyle(.bordered)

            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .offset(y: 80)
        )
        .cornerRadius(12)
        .padding()
        
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        
        ZStack {
            
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(12)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(12)
        
    }
    
    private var titleSection: some View {
        
        VStack(alignment: .leading, spacing: 4.0) {
            
            Text(location.name)
                .font(Font.title2)
                .fontWeight(Font.Weight.bold)
                .lineLimit(1)
            
            Text(location.cityName)
                .font(Font.subheadline)
        }

    }
    
    private var learnMoreButton: some View {
        
        Button {
            //
        } label: {
            Text("Learn More")
                .font(Font.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 30)
        }
        .buttonStyle(.borderedProminent)
        
    }
    
    private var backButton: some View {
        
        Button {
            //
            vm.isSlideFromLeadingToTrailing = true
            
            vm.isMenuButton = false
            vm.backButtonPressed()
        } label: {
            Text("Back")
                .frame(maxWidth: .infinity)
                .frame(height: 30)
        }
        
    }
    
    private var nextButton: some View {
        
        Button {
            //
            vm.isSlideFromLeadingToTrailing = false
            
            vm.isMenuButton = false
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .frame(maxWidth: .infinity)
                .frame(height: 30)
        }
        
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            
            Color.green
                .ignoresSafeArea()
            
            LocationPreviewView(location: LocationsDataService.locations.first!)
                .environmentObject(LocationsViewModel())
        }
        
    }
}
