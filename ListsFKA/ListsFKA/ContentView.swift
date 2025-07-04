import SwiftUI

struct ContentView: View {
    enum Field: Hashable {
        case fieldId(Int)
    }
    
    @State private var inFocus: Field?
    
    init(inFocus: Field? = nil) {
        self.inFocus = inFocus
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button("focusable button") {}
                    .id(Field.fieldId(0))
                    .focusable()
                    .customFocus()
                
                Text("focusable text")
                    .focusable()
                    .customFocus()
                
                NavigationLink {
                    TextFieldsList()
                } label: {
                    Text("List with Text Fields")
                }
                
                NavigationLink {
                    ButtonsList() }
                label: {
                    Text("List with Buttons")
                }
                
                NavigationLink {
                    MixedList() }
                label: {
                    Text("Mixed List with Custom Focus")
                }
                
                NavigationLink {
                    ScrollViewTest()
                } label: {
                     Text("Using a Scroll View instead")
                        .font(.headline)
                }
                
                // navigatioon breaks
                List {
                    Text("Text")
                        .accessibilityAddTraits(.isButton)
                        .id(Field.fieldId(0))
                        .focusable()
                        .focusableField(id: Field.fieldId(0), focusedField: $inFocus)
                    
                    Button("Button") {}
                        .id(Field.fieldId(1))
                        .focusableField(id: Field.fieldId(1), focusedField: $inFocus)
                    
                    TextField("Enter text...", text: .constant(""))
                        .id(Field.fieldId(2))
                        .focusableField(id: Field.fieldId(2), focusedField: $inFocus)
                }
                .onChange(of: inFocus) { _, newValue in
                    print("Currently focused: \(String(describing: newValue))")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
