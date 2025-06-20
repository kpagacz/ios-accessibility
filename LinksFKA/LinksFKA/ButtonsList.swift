//
//  TextFieldsList.swift
//  LinksFKA
//
//  Created by Natalia on 20/06/2025.
//

import SwiftUI

struct ButtonsList: View {
    enum Field: Hashable {
        case fieldId(Int)
    }

    @State private var inFocus: Field?
    
    init(inFocus: Field? = nil) {
           self.inFocus = inFocus
    }

    
    // doesn't override the focus effect
    var body: some View {
        List {
            ForEach(1..<5, id: \.self) { i in
                Button("Button \(i)") {}
                    .id(Field.fieldId(i))
                    .focusable()
                    .focusableField(id: Field.fieldId(i), focusedField: $inFocus)
            }
        }
        .onChange(of: inFocus) { _, newValue in
            print("Currently focused: \(String(describing: newValue))")
        }
    }
}

#Preview {
    TextFieldsList()
}
