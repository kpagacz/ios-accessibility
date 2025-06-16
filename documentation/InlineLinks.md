# Inline Links

Inline links are not keyboard focusable when using `Text(_: AttributedString)`,
even when they are correctly attributed. See: <https://github.com/cvs-health/ios-swiftui-accessibility-techniques/blob/main/iOSswiftUIa11yTechniques/Documentation/Links.md>.

Example:

```{swift}
import SwiftUI
import PlaygroundSupport

func attributedStringWithLinks(from text: String) -> AttributedString {
    // Create base attributed string
    var attributedString = AttributedString(text)

    // Regular expression to detect URLs
    let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
    let matches = detector.matches(in: text,
                                  options: [],
                                  range: NSRange(location: 0, length: text.count))

    // Apply link attributes to all detected URLs
    for match in matches {
        guard let range = Range(match.range, in: attributedString),
              let url = match.url else { continue }

        // Set link attributes
        attributedString[range].link = url
        attributedString[range].underlineStyle = .single
        attributedString[range].foregroundColor = .blue
    }

    return attributedString
}

// Usage in SwiftUI
struct ContentView: View {
    let message = """Visit our websites example.com https://example.com or
contact support@company.com for help. Check our repo at github.com/ourproject
"""

    var body: some View {
        Text(attributedStringWithLinks(from: message))
            .environment(\.openURL, OpenURLAction { url in
                print("Opening URL: \(url)")
                UIApplication.shared.open(url)
                return .handled
            })
            .padding()
            .font(.body)
            .lineSpacing(8)
    }
}

PlaygroundPage.current.setLiveView(ContentView())
```
