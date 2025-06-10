import SwiftUI

/// Basic chat screen to interact with the AI coach.
/// In an upcoming iteration this will connect to the backend streaming endpoint.
struct CoachChatView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(role: .assistant, text: "Hello! I'm your AI coach. How can I help you today?")
    ]
    @State private var inputText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(messages) { message in
                            Bubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                }
                .onChange(of: messages.count) { _ in
                    if let last = messages.last {
                        withAnimation {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }

            Divider()
                .background(Color.secondaryText.opacity(0.2))

            inputBar
        }
        .background(Color.ivory.ignoresSafeArea())
        // App is set to always use dark mode in Info.plist
        .navigationTitle("AI Coach")
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: – Input Bar
    private var inputBar: some View {
        HStack(spacing: 12) {
            TextField("Type a question…", text: $inputText)
                .font(.barlowCondensedBody())
                .padding(10)
                .background(Color.cardBackground)
                .cornerRadius(16)
                .submitLabel(.send)
                .onSubmit(send)

            Button(action: send) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 
                                    Color.brandGreen.opacity(0.5) : Color.brandGreen)
                    .frame(width: 44, height: 44)
                    .background(Color.cardBackground)
                    .cornerRadius(22)
            }
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.ivory)
        .shadow(color: Color.shadowColor, radius: 3, x: 0, y: -2)
    }

    private func send() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        messages.append(ChatMessage(role: .user, text: trimmed))
        inputText = ""

        // Simulate assistant reply
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            messages.append(ChatMessage(role: .assistant, text: "This is a placeholder response. We'll connect to the real AI soon!"))
        }
    }
}

#Preview {
    CoachChatView()
}

// MARK: – Components & Models
private struct Bubble: View {
    let message: ChatMessage
    var isUser: Bool { message.role == .user }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if isUser { 
                Spacer() 
            } else {
                Image(systemName: "figure.mind.and.body")
                    .font(.system(size: 24))
                    .foregroundColor(.brandGreen)
                    .frame(width: 32, height: 32)
            }

            Text(message.text)
                .font(.barlowCondensedBody())
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(isUser ? Color.userBubble : Color.assistantBubble)
                .foregroundColor(isUser ? .buttonText : .primaryText)
                .cornerRadius(16)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: isUser ? .trailing : .leading)
                .shadow(color: Color.shadowColor, radius: 2, x: 0, y: 1)

            if isUser { 
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.accentOrange)
                    .frame(width: 32, height: 32)
            } else {
                Spacer() 
            }
        }
        .padding(.vertical, 4)
    }
}

private struct ChatMessage: Identifiable {
    enum Role { case user, assistant }
    let id = UUID()
    let role: Role
    let text: String
} 
