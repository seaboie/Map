//
//  LocationMapAnnotationView.swift
//  Map
//
//  Created by Kritbovorn Taweeyossak on 3/1/2565 BE.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    
    let accentColor = Color("AccentColor")
    
    var body: some View {
        
        VStack(spacing: 0.0) {
            
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: Alignment.center)
                .foregroundColor(Color.white)
                .padding(5)
                .background(accentColor)
                .cornerRadius(40)
            
            Image(systemName: "arrowtriangle.right.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(accentColor)
                .frame(width: 18, height: 18, alignment: Alignment.center)
                .rotationEffect(Angle(degrees: 90))
                .offset(y: -5)
                .padding(.bottom, 45)
        }
        
    }
}
struct LocationMapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            LocationMapAnnotationView()
        }
    }
}
