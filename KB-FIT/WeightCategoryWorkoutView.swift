// WeightCategoryWorkoutView.swift

import SwiftUI

struct WeightCategoryWorkoutView: View {
    let imc: Double

    var body: some View {
        VStack {
            if imc < 18.5 {
                Text("Vous êtes en insuffisance pondérale. Voici quelques entraînements recommandés pour vous.")
            } else if imc >= 18.5 && imc < 25 {
                Text("Vous avez un poids normal. Voici quelques entraînements recommandés pour vous.")
            } else if imc >= 25 && imc < 30 {
                Text("Vous êtes en surpoids. Voici quelques entraînements recommandés pour vous.")
            } else {
                Text("Vous êtes en situation d'obésité. Voici quelques entraînements recommandés pour vous.")
            }
        }
        .padding()
        .navigationTitle("Entraînements recommandés")
    }
}

struct WeightCategoryWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WeightCategoryWorkoutView(imc: 25)
    }
}
