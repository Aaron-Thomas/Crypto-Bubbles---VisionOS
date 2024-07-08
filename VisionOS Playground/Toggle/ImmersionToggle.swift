//
//  ImmersionToggle.swift
//  VisionOS Playground
//
//  Created by Aaron Thomas on 04/07/2024.
//

import SwiftUI

/// A toggle that activates or deactivates the bubbles volumetric view.
struct ImmersionToggle: View {
    @Environment(BubblesViewModel.self) private var viewModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    var body: some View {
        Button {
            Task {
                if viewModel.isShowingImmersiveBubbles {
                    await dismissImmersiveSpace()
                } else {
                    await openImmersiveSpace(id: "bubbles-immersive")
                }
            }
        } label: {
            if viewModel.isShowingImmersiveBubbles {
                Label(
                    "Exit Immersion View",
                    systemImage: "arrow.down.right.and.arrow.up.left")
            } else {
                Text("Enter Immersive View")
            }
        }
    }
}

#Preview {
    ImmersionToggle()
        .environment(BubblesViewModel())
}
