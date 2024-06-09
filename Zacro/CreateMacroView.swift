import SwiftUI

struct CreateMacroView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var macros: [Macro]
    
    @State private var macroName: String = ""
    @State private var keyInput: String = ""
    
    var body: some View {
        VStack {
            TextField("Macro Name", text: $macroName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Key to Press", text: $keyInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button(action: saveMacro) {
                    Text("Save")
                        .padding()
                        .cornerRadius(8)
                }
                .disabled(macroName.isEmpty || keyInput.isEmpty)
                
                Button(action: cancel) {
                    Text("Cancel")
                        .padding()
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .padding()
    }
    
    func saveMacro() {
        let newMacro = Macro(name: macroName, key: keyInput)
        macros.append(newMacro)
        presentationMode.wrappedValue.dismiss()
    }
    
    func cancel() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateMacroView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMacroView(macros: .constant([]))
    }
}

