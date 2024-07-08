//
//  BubbleData.swift
//  VisionOS Playground
//
//  Created by Aaron Thomas on 08/07/2024.
//

import Foundation
import RealityKit

struct CryptoBubble: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let priceChange: Double
}

struct BubbleData {
    var entity: ModelEntity
    var position: SIMD3<Float>
    var velocity: SIMD3<Float>
    var radius: Float
}
