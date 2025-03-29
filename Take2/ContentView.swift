//
//  ContentView.swift
//  Take2
//
//  Created by Nathan Choi on 3/27/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {

    @State var imageSelection: PhotosPickerItem? = nil
    @State var image: Image?

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("Image Lab")
                .font(.title)
                .fontDesign(.serif)

            HStack(spacing: 5) {
                Image(systemName: "ticket.fill")
                    .foregroundStyle(.yellow)

                Text("10 Credits")
                    .font(.caption)
                    .fontWeight(.semibold)
            }

            ZStack {
                Spacer()

                if let image {
                    Color(.secondarySystemBackground)

                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .transition(.opacity)
                } else {
                    FloatingBlobView(size: 300, color: .blue)
                    FloatingBlobView(size: 300, color: .yellow)
                    FloatingBlobView(size: 200, color: .blue)
                    FloatingBlobView(size: 200, color: .orange)
                }
            }
                .aspectRatio(0.75, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [4]))
                )
                .animation(.spring(), value: image)

            Spacer()

            PhotosPicker(selection: $imageSelection,
                         matching: .images,
                         photoLibrary: .shared())
            {
                LazyVStack {
                    Text("Select Photo  \(Image(systemName: "photo"))")
                        .foregroundStyle(Color(.systemBackground))
                        .fontWeight(.medium)
                        .padding(.vertical, 15)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.primary)
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(15)
        .onChange(of: imageSelection) { oldValue, newValue in
            Task {
                if let loaded = try? await imageSelection?.loadTransferable(
                    type: Image.self
                ) {
                    image = loaded
                } else {
                    print("Failed to load image.")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
