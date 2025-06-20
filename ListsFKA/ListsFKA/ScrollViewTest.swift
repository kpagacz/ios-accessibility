//
//  ScrollViewTest.swift
//  LinksFKA
//
//  Created by Natalia on 20/06/2025.
//

import SwiftUI

struct ScrollViewTest: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Button("button") {}
                    .focusable()
                    .customFocus()
                
                GroupBox(
                    label:
                    Text("Group Box"),
                    content: {},
                )
                .groupBoxStyle(.automatic)
                .onTapGesture {
                    print("group box tapped")
                }
                .accessibilityAddTraits(.isButton)
                .focusable()
                .customFocus()
                
                Text("Text")
                
                Button("button") {}
            }
        }
    }
}

#Preview {
    ScrollViewTest()
}
