import SwiftUI

struct CustomFocuse: ViewModifier {
    @FocusState var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .focused($isFocused)
            .background(isFocused ? .red : .clear)
            .overlay {
                Rectangle()
                    .foregroundStyle(isFocused ? .red : .clear)

            }
    }
}

extension View {
    func customFocus() -> some View {
        modifier(CustomFocuse())
    }
}
