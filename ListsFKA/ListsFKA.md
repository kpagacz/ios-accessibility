# Focus Handling in SwiftUI Lists

## Problem Overview

When using **Full Keyboard Access (FKA)** or other accessibility-related focus systems in SwiftUI, we encountered an issue where **custom focus effects are overridden** within `List` elements.

### ❗ The Issue

SwiftUI automatically applies system-level focus effects to elements inside a `List`. These built-in effects **override any custom focus visuals** you may define using `.focused(...)`, `.overlay(...)`, `.border(...)`, or custom `ViewModifier`s.

As a result:
- Custom focus indicators (e.g. border color changes) do **not render properly** inside a `List`.
- The `@FocusState` value changes correctly, but the **UI does not reflect** the custom styles.
- This interferes with providing a consistent, visible focus experience, especially for keyboard users.

### 💡 Why This Happens

SwiftUI `List` is a highly abstracted view, which internally manages:
- Row rendering
- Reuse and recycling
- Accessibility and focus effects

Because of this, any custom focus styling applied at the row or cell level may be **clipped or overridden** by the system.

### 🔍 What Works and What Doesn’t

Found a workaround that works only for TextFields

| Element Type | Custom Focus Effect Works? | Notes |
|--------------|-----------------------------|-------|
| `TextField`  | ✅ Yes                       | `TextField` correctly reflects `@FocusState` and allows visual updates. |
| `Button`     | ❌ No                        | SwiftUI overrides custom focus visuals in lists. |
| `Text`       | ❌ No                        | Same issue as above — system rendering takes over. |

---

## `.focusable()` Behavior

Calling `.focusable()` **forces the system to allow focus** on elements like `Text` or `Button`, and **enables** your custom focus effect (e.g., `.border(...)`, `.background(...)`).

However:

### ⚠️ **Drawback: Breaks List Navigation**

Using `.focusable()` **within a `List`** disables or breaks the native keyboard navigation behavior — for example:

- Arrow keys no longer move focus between rows
- Tab key focus cycle behaves incorrectly
- System accessibility expectations are not respected

---

## Workaround

To ensure consistent visual focus indicators:

### ✅ Move focusable elements **outside of `List`**, when feasible

Instead of placing focusable controls (e.g. warning banners, text fields) **inside** a `List`, render them **above or below** the `List`, or wrap them in a `ScrollView` or `VStack`.

This allows:
- Full control over focus styling
- Reliable use of `@FocusState` and `@Binding`
- Visual feedback that matches keyboard navigation
