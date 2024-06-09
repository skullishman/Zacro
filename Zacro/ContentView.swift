import SwiftUI

struct Macro: Identifiable {
    let id = UUID()
    let name: String
    let key: String
}

struct ContentView: View {
    @State private var macros: [Macro] = []
    @State private var selectedMacro: Macro?
    @State private var isRunning: Bool = false
    @State private var showingCreateMacroView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Button(action: { showingCreateMacroView = true }) {
                    Text("Create Macro")
                }
                
                ForEach(macros) { macro in
                    Button(action: {
                        selectedMacro = macro
                    }) {
                        Text(macro.name)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            
            VStack {
                if let selectedMacro = selectedMacro {
                    Text("Selected Macro: \(selectedMacro.name)")
                    HStack {
                        Button(action: {
                            startMacro(macro: selectedMacro)
                        }) {
                            Text("Run")
                                .padding()
                                .cornerRadius(8)
                        }
                        .disabled(isRunning)
                        
                        Button(action: stopMacro) {
                            Text("Stop")
                                .padding()
                                .cornerRadius(8)
                        }
                        .disabled(!isRunning)
                    }
                } else {
                    Text("No macro selected")
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingCreateMacroView) {
            CreateMacroView(macros: $macros)
        }
    }
    
    func startMacro(macro: Macro) {
        isRunning = true
        DispatchQueue.global(qos: .background).async {
            while self.isRunning {
                simulateKeyPress(macro.key)
                usleep(100000) // Adjust the delay as needed
            }
        }
    }
    
    func stopMacro() {
        isRunning = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

