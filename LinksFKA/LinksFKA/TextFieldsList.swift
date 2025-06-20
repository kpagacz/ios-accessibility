//
//  TextFieldsList.swift
//  LinksFKA
//
//  Created by Natalia on 20/06/2025.
//

import SwiftUI

struct TextFieldsList: View {
    enum Field: Hashable {
        case fieldId(Int)
    }

    @State private var inFocus: Field?
    
    init(inFocus: Field? = nil) {
           self.inFocus = inFocus
    }

    var body: some View {
        List {

            ForEach(1..<5, id: \.self) { i in
                TextField("Enter text for \(i)", text: .constant(""))
                    .id(Field.fieldId(i))
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
