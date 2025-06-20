import SwiftUI

struct FocusableFieldModifier<Field: Hashable>: ViewModifier {
    let id: Field
    @Binding var focusedField: Field?
    @FocusState private var isFocused: Bool
    @State private var borderColor: Color = .clear

    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .background(borderColor)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(borderColor, lineWidth: 2)
            )
            .onChange(of: isFocused) { _, focused in
                if focused {
                    focusedField = id
                }
                borderColor = focused ? .red : .blue
            }
            .onChange(of: focusedField) { _, newValue in
                if newValue == id {
                    focusedField = id
                    isFocused = true
                }
            }
    }
}

extension View {
    func focusableField<Field: Hashable>(
        id: Field,
        focusedField: Binding<Field?>
    ) -> some View {
        self.modifier(FocusableFieldModifier(id: id, focusedField: focusedField))
    }
}

enum Field: Hashable {
        case fieldId(Int)
    }
