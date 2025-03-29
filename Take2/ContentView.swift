//
//  ContentView.swift
//  Take2
//
//  Created by Nathan Choi on 3/27/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {

    @Namespace private var homescreen
    @Namespace private var buttonBg
    @Namespace private var buttonText

    @State private var imageSelection: PhotosPickerItem? = nil
    @State private var image: Image?

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            HStack {
                VStack(alignment: .leading, spacing: 10) {
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
                }

                Image(systemName: "")
            }

            ZStack {

                Color.clear

                if let image {
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

            Spacer()

            HStack(spacing: 15) {

                if image != nil {
                    Button { withAnimation { image = nil } } label: {
                        Text("Discard")
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 25)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.secondarySystemBackground))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                if image == nil {
                    PhotosPicker(selection: $imageSelection,
                                 matching: .images,
                                 photoLibrary: .shared())
                    {
                        LazyVStack {
                            Text("Select Photo")
                                .foregroundStyle(Color(.systemBackground))
                                .fontWeight(.medium)
                                .padding(.vertical, 15)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.primary)
                        )
                        .matchedGeometryEffect(id: buttonBg, in: homescreen)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .transition(.offset())
                } else {
                    Button {} label: {
                        LazyVStack {
                            Text("\(Image(systemName: "wand.and.stars"))  Generate Results")
                                .foregroundStyle(Color(.systemBackground))
                                .fontWeight(.medium)
                                .padding(.vertical, 15)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.primary)
                        )
                        .matchedGeometryEffect(id: buttonBg, in: homescreen)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .transition(.offset())
                }
            }
        }
        .padding(15)
        .onChange(of: imageSelection) { oldValue, newValue in
            Task(priority: .userInitiated) {
                if let loaded = try? await imageSelection?.loadTransferable(
                    type: Image.self
                ) {
                    withAnimation(.spring()) {
                        image = loaded
                    }
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
