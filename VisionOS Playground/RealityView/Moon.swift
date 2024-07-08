//
//  Moon.swift
//  VisionOS Playground
//
//  Created by Aaron Thomas on 04/07/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct Moon: View {
    
    var body: some View {
        RealityView { content in
            if let moonEntity = await RealityKitContent.entity(named: "Moon") {
                let moonScale: Float = 5
                moonEntity.scale = [moonScale, moonScale, moonScale]
                let moonPosition: SIMD3<Float> = [2.5, 2.5, -3]
                moonEntity.position = moonPosition
                content.add(moonEntity)
            } else {
                print("Failed to load Moon Entity")
            }
        }
    }
}
