import SwiftUI

struct TextFieldAlert<Presenting>: View where Presenting: View {
    @Binding var isPresented: Bool
    @Binding var text: String
    @Binding var color: Color
    let onDone: () -> Void
    let presenting: Presenting

    var body: some View {
        ZStack {
            if isPresented {
                presenting
                    .blur(radius: 2)
                VStack {
                    Text("Enter the title for the new calendar:")
                    TextField("Calendar title", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    ColorPicker("Select Calendar Color", selection: $color)
                        .padding()
                    HStack {
                        Button("Cancel") {
                            isPresented = false
                        }
                        .buttonStyle(.bordered)
                        Button("Create") {
                            isPresented = false
                            onDone()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .shadow(radius: 10)
                .frame(maxWidth: 300)
            } else {
                presenting
            }
        }
    }
}
