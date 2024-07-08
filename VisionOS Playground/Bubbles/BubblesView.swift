//
//  ContentView.swift
//  VisionOS Playground
//
//  Created by Aaron Thomas on 04/07/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct BubblesView: View {

    @Environment(BubblesViewModel.self) private var viewModel
    @State var bubbles: [BubbleData] = []
        
    var body: some View {
        Moon()
        RealityView { content in
            await setupBubbles(for: viewModel.bubbleData, in: content)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                updateBubbles()
            }
        }
    }
    
    private func setupBubbles(for coins: [CryptoBubble], in content: RealityViewContent) async {
        for coin in coins {
            let radius = max(0.1, abs(coin.priceChange) / 50)
            let color: UIColor = coin.priceChange >= 0 ? .green : .red
            let material = SimpleMaterial(color: color, isMetallic: false)
            let mesh = MeshResource.generateSphere(radius: Float(radius))
            let bubbleEntity = ModelEntity(mesh: mesh, materials: [material])
            
            let imageEntity = await createImageEntity(for: coin.icon, radius: Float(radius))
            let textEntity1 = createTextEntity(
                for: coin.name,
                radius: Float(radius),
                xOffset: Float(-radius) / 3,
                yOffset: (Float(-radius) / 4.5)
            )
            let xOffset = Float(-radius) / (coin.priceChange < 0 ? 2.5 : 3.2)
            let textEntity2 = createTextEntity(
                for: "\(coin.priceChange)%",
                radius: Float(radius),
                xOffset: xOffset,
                yOffset: (Float(-radius) / 2)
            )
            
            let combinedEntity = ModelEntity()
            combinedEntity.addChild(bubbleEntity)
            combinedEntity.addChild(imageEntity)
            combinedEntity.addChild(textEntity1)
            combinedEntity.addChild(textEntity2)
            
            let position = generateNonOverlappingPosition(existingPositions: bubbles.map { $0.position }, radius: Float(radius))
            combinedEntity.position = position
            
            let velocity = randomVelocity()
            let bubbleData = BubbleData(entity: combinedEntity, position: position, velocity: velocity, radius: Float(radius))
            bubbles.append(bubbleData)
            
            content.add(combinedEntity)
        }
    }
    
    private func createTextEntity(for text: String,
                                  radius: Float,
                                  xOffset: Float,
                                  yOffset: Float) -> ModelEntity {
        let textMesh = MeshResource.generateText(
            text, extrusionDepth: 0.01,
            font: .systemFont(ofSize: CGFloat(radius) / 4),
            containerFrame: .zero, alignment: .center, lineBreakMode: .byWordWrapping)
        
        var textMaterial = UnlitMaterial()
        textMaterial.color = .init(tint: .white)

        let textEntity = ModelEntity(mesh: textMesh, materials: [textMaterial])
        textEntity.position = [xOffset, yOffset, radius + 0.01]
        textEntity.orientation = simd_quatf(angle: 0, axis: [0, 1, 0])
        return textEntity
    }
    
    private func createImageEntity(for url: String, radius: Float) async -> ModelEntity {
        guard
            let imageURL = URL(string: url),
            let (data, _) = try? await URLSession.shared.data(from: imageURL),
            let image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal)
        else { return ModelEntity() }
        
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempURL = tempDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
        try? image.pngData()?.write(to: tempURL)
        
        guard let texture = try? await TextureResource.init(contentsOf: tempURL) else {
            return ModelEntity()
        }
        var material = UnlitMaterial()
        material.color = .init(texture: .init(texture))
        
        let imageSize = radius / 3
        let circleMesh = generateCircleMesh(radius: imageSize)
        let imageEntity = ModelEntity(mesh: circleMesh, materials: [material])
        imageEntity.position = [0, imageSize / 2 + 0.03, radius + 0.01]
        imageEntity.transform.rotation = simd_quatf(angle: 0, axis: [0, 0, 1])
        
        return imageEntity
    }
    
    private func generateCircleMesh(radius: Float, segments: Int = 32) -> MeshResource {
        var vertices: [SIMD3<Float>] = []
        var indices: [UInt32] = []
        var textureCoordinates: [SIMD2<Float>] = []

        vertices.append([0, 0, 0])
        textureCoordinates.append([0.5, 0.5])

        for i in 0...segments {
            let angle = Float(i) * 2.0 * .pi / Float(segments)
            let x = radius * cos(angle)
            let y = radius * sin(angle)
            vertices.append([x, y, 0])
            textureCoordinates.append([0.5 + 0.5 * cos(angle), 0.5 + 0.5 * sin(angle)])
        }
        
        for i in 1...segments {
            indices.append(0)
            indices.append(UInt32(i))
            indices.append(UInt32(i % segments + 1))
        }
        
        var meshDescriptor = MeshDescriptor()
        meshDescriptor.positions = MeshBuffer(vertices)
        meshDescriptor.primitives = .triangles(indices)
        meshDescriptor.textureCoordinates = MeshBuffer(textureCoordinates)
        
        return try! MeshResource.generate(from: [meshDescriptor])
    }
    
    private func generateNonOverlappingPosition(existingPositions: [SIMD3<Float>], radius: Float) -> SIMD3<Float> {
        let minDistance = radius * 2
        var position: SIMD3<Float>
        
        repeat {
            position = SIMD3<Float>(
                Float.random(in: -0.5...0.5),
                Float.random(in: -0.5...0.5),
                Float.random(in: -0.5...0.5)
            )
        } while existingPositions.contains(where: { simd_distance($0, position) < minDistance })

        return position
    }
    
    private func randomVelocity() -> SIMD3<Float> {
        return SIMD3<Float>(
            Float.random(in: -0.005...0.005),
            Float.random(in: -0.005...0.005),
            Float.random(in: -0.005...0.005)
        )
    }
    
    private func updateBubbles() {
        for i in 0..<bubbles.count {
            var bubble = bubbles[i]
            
            bubble.position += bubble.velocity
            
            // Check for collisions with walls
            if bubble.position.x - bubble.radius < -0.5 || bubble.position.x + bubble.radius > 0.5 {
                bubble.velocity.x *= -1
            }
            if bubble.position.y - bubble.radius < -0.5 || bubble.position.y + bubble.radius > 0.5 {
                bubble.velocity.y *= -1
            }
            if bubble.position.z - bubble.radius < -0.5 || bubble.position.z + bubble.radius > 0.5 {
                bubble.velocity.z *= -1
            }
            
            // Check for collisions with other bubbles
            for j in 0..<bubbles.count where i != j {
                let distance = simd_distance(bubble.position, bubbles[j].position)
                let minDistance = bubble.radius + bubbles[j].radius
                
                if distance < minDistance {
                    let separationVector = bubble.position - bubbles[j].position
                    let separationDistance = minDistance - distance
                    let separationDirection = normalize(separationVector)
                    let separation = separationDirection * separationDistance * 0.5
                    
                    bubble.position += separation
                    bubble.velocity *= -1
                }
            }
            
            // Ensure bubble stays within the visible area
            bubble.position.x = max(-0.5 + bubble.radius, min(bubble.position.x, 0.5 - bubble.radius))
            bubble.position.y = max(-0.5 + bubble.radius, min(bubble.position.y, 0.5 - bubble.radius))
            bubble.position.z = max(-0.5 + bubble.radius, min(bubble.position.z, 0.5 - bubble.radius))
            
            // Update the entity's position
            bubble.entity.position = bubble.position
            
            bubbles[i] = bubble
        }
    }
}
