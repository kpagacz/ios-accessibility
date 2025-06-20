//
//  TextFieldsList.swift
//  LinksFKA
//
//  Created by Natalia on 20/06/2025.
//

import SwiftUI

struct MixedList: View {
    enum Field: Hashable {
        case fieldId(Int)
    }

    @State private var inFocus: Field?
    
    init(inFocus: Field? = nil) {
           self.inFocus = inFocus
    }

    var body: some View {
        List {
            Text("Text \(0)")
                .accessibilityAddTraits(.isButton)
//                .id(Field.fieldId(0))
                .focusable()
                .customFocus()
            
            Button("Button \(1)") {}
//                .id(Field.fieldId(1))
                .focusable()
                .customFocus()
            
        }
        .onChange(of: inFocus) { _, newValue in
            print("Currently focused: \(String(describing: newValue))")
        }
    }
}

#Preview {
    TextFieldsList()
}
