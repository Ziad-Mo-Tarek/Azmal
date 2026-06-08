//
//  ButtonViewModifiers.swift
//  AIChatCourse
//
//  Created by Ziad Tarek on 20/04/2026.
//

import SwiftUI


struct HighlightedButtonStyle :ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay {
                configuration.isPressed ? Color.primaryApp.opacity(0.4) : Color.primaryApp.opacity(0)
            }
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct PressableButtonStyle :ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.smooth, value: configuration.isPressed)
    }
}

enum ButtonStyleOption {
    case press, highlight, plain
}

extension View {
    
    @ViewBuilder
    func anyButton(_ option: ButtonStyleOption = .plain, action: @escaping () -> Void) -> some View {
        switch option {
        case .highlight:
            self.highlightButton(action: action)
        case .press:
            self.pressableButton(action: action)
        case .plain:
            self.plainButton(action: action)
        }
    }
    
    private func highlightButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(HighlightedButtonStyle())
    }
    
    private func pressableButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(PressableButtonStyle())
    }
    
    private func plainButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            self
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    VStack {
        Text("hello, world!")
            .tapableBackgrounf()
            .anyButton(.highlight, action: {
                
            })
            .padding()
        
        Text("hello, world!")
            .callToActionButton()
            .anyButton(.press, action: {
                
            })
            .padding()
        
        Text("hello, world!")
            .callToActionButton()
            .anyButton(.plain, action: {
                
            })
            .padding()
    }
}
