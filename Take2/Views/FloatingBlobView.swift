//
//  FloatingBlobs.swift
//  Take2
//
//  Created by Nathan Choi on 3/28/25.
//

import SwiftUI


struct FloatingBlobView: View {
    let size: CGFloat
    let color: Color
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            RadialGradient(gradient: Gradient(colors: [
                color.opacity(0.8),
                color.opacity(0.5),
                Color.clear
            ]), center: .center, startRadius: size / 4, endRadius: size / 1.2)
            .frame(width: size, height: size)
            .blur(radius: size / 4)
            .position(x: width / 2 + offsetX, y: height / 2 + offsetY)
            .onAppear {
                offsetX = CGFloat.random(in: -width / 3...width / 3)
                offsetY = CGFloat.random(in: -height / 3...height / 3)
                animateBlob(width: width, height: height)
            }
        }
    }

    private func animateBlob(width: CGFloat, height: CGFloat) {
        withAnimation(
            Animation.easeInOut(duration: Double.random(in: 4...8))
                .repeatForever(autoreverses: true)
        ) {
            offsetX = CGFloat.random(in: -width / 3...width / 3)
            offsetY = CGFloat.random(in: -height / 3...height / 3)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 4...8)) {
            animateBlob(width: width, height: height)
        }
    }
}

#Preview {
    ZStack {
        FloatingBlobView(size: 400, color: .red)
        FloatingBlobView(size: 400, color: .blue)
        FloatingBlobView(size: 400, color: .green)
        FloatingBlobView(size: 400, color: .blue)
    }
}
