//
//  VisionOSApp.swift
//  VisionOS Playground
//
//  Created by Aaron Thomas on 04/07/2024.
//

import SwiftUI

@main
struct VisionOSApp: App {
    
    @State private var viewModel = BubblesViewModel()
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    
    @State private var bubblesImmersionStyle: ImmersionStyle = .full
    
    var body: some Scene {
        // Plain Window View
        WindowGroup(id: "bubbles-window") {
            LandingView()
                .environment(viewModel)
            ImmersionToggle()
                .environment(viewModel)
                .opacity(viewModel.isShowingImmersiveBubbles ? 1 : 0)
        }
        .windowStyle(.plain)

        // Volumetric View
        WindowGroup(id: "bubbles-volumetric") {
            BubblesView()
                .environment(viewModel)
                .onAppear {
                    viewModel.isShowingVolumeticBubbles = true
                }
                .onDisappear {
                    viewModel.isShowingVolumeticBubbles = false
                }
        }
        .windowStyle(.volumetric)
        
        // Immersive View
        ImmersiveSpace(id: "bubbles-immersive") {
            ZStack {
                BubblesView()
                    .environment(viewModel)
                Starfield()
            }
            .onAppear {
                viewModel.isShowingImmersiveBubbles = true
            }
            .onDisappear {
                viewModel.isShowingImmersiveBubbles = false
            }
        }
        .immersionStyle(selection: $bubblesImmersionStyle, in: .full)
    }
}
