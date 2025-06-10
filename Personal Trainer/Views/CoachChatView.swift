import SwiftUI

/// Basic chat screen to interact with the AI coach.
/// In an upcoming iteration this will connect to the backend streaming endpoint.
struct CoachChatView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(role: .assistant, text: "Hello! I'm your AI coach. How can I help you today?")
    ]
    @State private var inputText: String = ""

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(messages) { message in
                            Bubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: messages.count) { _ in
                    if let last = messages.last {
                        proxy.scrollTo(last.id, anchor: .bottom)
                    }
                }
            }

            inputBar
        }
        .background(Color.ivory.ignoresSafeArea())
        .navigationTitle("AI Coach")
    }

    // MARK: – Input Bar
    private var inputBar: some View {
        HStack {
            TextField("Type a question…", text: $inputText)
                .font(.barlowCondensedBody())
                .textFieldStyle(.roundedBorder)
                .submitLabel(.send)
                .onSubmit(send)

            Button(action: send) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.brandGreen)
            }
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
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
        HStack {
            if isUser { Spacer() }

            Text(message.text)
                .font(.barlowCondensedBody())
                .padding(10)
                .background(isUser ? Color.brandGreen : Color.mustard.opacity(0.3))
                .foregroundColor(isUser ? .white : .charcoal)
                .cornerRadius(12)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: isUser ? .trailing : .leading)

            if !isUser { Spacer() }
        }
    }
}

private struct ChatMessage: Identifiable {
    enum Role { case user, assistant }
    let id = UUID()
    let role: Role
    let text: String
} 
