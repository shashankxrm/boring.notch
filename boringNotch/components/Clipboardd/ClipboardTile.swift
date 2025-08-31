//
//  ClipboardTile.swift
//  boringNotch
//
//  Created by Shashank Reddy on 31/08/25.
//

import SwiftUI
import AppKit


struct ClipboardTile: View {
    var text: String
    var bundleID: String
    @State private var isCopied: Bool = false

    init(text: String, bundleID: String) {
        self.text = text
        self.bundleID = bundleID
    }

    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.4))
            .opacity(0.2)
            .overlay(
                clipboardLabel
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
            .frame(width: 140, height: 120)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                ClipboardMonitor.CopyFromApp(text)
                isCopied = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isCopied = false
                }
            }
    }

    private var clipboardLabel: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(text)
                .foregroundStyle(.white.opacity(0.9))
                .padding(.top, 10)
                .padding(.horizontal, 5)
                .lineLimit(2)
                .padding(.leading, 5)
                .font(.system(.body, design: .rounded))
                .frame(height: 50)
            HStack(alignment: .center) {
                ZStack{
                    clipboardIconBackground
                    AppIcon(for: bundleID)
                        .opacity(0.85)
                }
                .padding(.bottom, 8)
                Spacer()
                Image(systemName: isCopied ? "checkmark": "clipboard")
                    .contentTransition(.symbolEffect(.replace))
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.trailing)
                    .padding(.bottom, 8)
                    .font(.system(.headline, design: .rounded))

            }
        }
        .contentShape(Rectangle())
    }

    private var clipboardIconBackground: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
            .background(
                AppIcon(for: bundleID)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .scaleEffect(x: 1.3, y: 3.4)
            .rotationEffect(.degrees(90))
            .blur(radius:40)
    }
}

#Preview {
    HStack{
        ClipboardTile(text: "Copia 1 Copia 1 Copia 1 Copia 1 .frame(height: 18)", bundleID: "com.apple.Notes")
        ClipboardTile(text: "Copia 2", bundleID: "com.spotify.client")
        ClipboardTile(text: "Copia 3", bundleID: "com.apple.music")
    }

}
