// EvolutionView.swift

import SwiftUI

struct EvolutionView: View {
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var showWeightCategoryWorkoutView: Bool = false
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Poids (kg)", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Taille (cm)", text: $height)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                Button(action: {
                    calculateIMC()
                }) {
                    Text("Calculez mon IMC")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: WeightCategoryWorkoutView(imc: calculateIMC()), isActive: $showWeightCategoryWorkoutView) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Évolution")
        }
    }
    
    func calculateIMC() -> Double {
        guard let weightValue = Double(weight), let heightValue = Double(height) else { return 0 }
        let heightInMeters = heightValue / 100.0
        let imc = weightValue / (heightInMeters * heightInMeters)

        // Mettez à jour l'état pour afficher la nouvelle vue
        showWeightCategoryWorkoutView = true
        
        return imc
    }
}

struct EvolutionView_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionView()
    }
}
