/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A toggle that activates or deactivates the solar system scene.
*/

import SwiftUI

/// A toggle that activates or deactivates the space  scene.
struct VolumetricToggle: View {
    @Environment(BubblesViewModel.self) private var viewModel
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some View {
        Button {
            Task {
                if viewModel.isShowingVolumeticBubbles {
                    dismissWindow(id: "bubbles-volumetric")
                } else {
                    openWindow(id: "bubbles-volumetric")
                }
            }
        } label: {
            if viewModel.isShowingVolumeticBubbles {
                Text("Hide Bubbles")
            } else {
                Text("Show Bubbles")
            }
        }
    }
}

#Preview {
    VolumetricToggle()
        .environment(BubblesViewModel())
}
