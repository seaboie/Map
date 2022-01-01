//
//  MapApp.swift
//  Map
//
//  Created by Kritbovorn Taweeyossak on 31/12/2564 BE.
//

import SwiftUI

@main
struct MapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            LocationsView()
                .environmentObject(vm)
        }
    }
}
