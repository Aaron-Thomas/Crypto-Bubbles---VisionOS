//
//  LandingView.swift
//  VisionOS Playground
//
//  Created by Aaron Thomas on 08/07/2024.
//

import SwiftUI

struct LandingView: View {
    
    @Environment(BubblesViewModel.self) private var viewModel
    
    var body: some View {
        ZStack {
            HStack(spacing: 60) {
                VStack(alignment: .leading, spacing: 0) {
                    VStack {
                        Text("Market Movers")
                            .font(.system(size: 50, weight: .bold))
                            .padding(.bottom, 16)
                        Text("View coin movements over various timeframes. For informational purposes only, not financial advice.")
                            .padding(.bottom, 24)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                        VolumetricToggle()
                            .environment(viewModel)
                        ImmersionToggle()
                            .environment(viewModel)
                    }
                    .padding()
                }
                .frame(width: 500, alignment: .leading)
                
                Image("coins")
                    .resizable()
                    .frame(width: 400, height: 400)
                    .padding(.vertical, 100)
                    .padding(.trailing, 40)
            }
        }
        .glassBackgroundEffect()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(viewModel.isShowingImmersiveBubbles ? 0: 1)
    }
}
