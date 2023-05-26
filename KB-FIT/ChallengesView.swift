import SwiftUI

struct ChallengesView: View {
    @State private var calorieGoal: Int = 2000
    @State private var caloriesBurned: Int = 0
    @State private var showCongratulations: Bool = false
    @State private var circleProgress: CGFloat = 0.0
    @State private var newCalorieGoal: String = ""

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Défis")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                VStack {
                    Text("Objectif calorique")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("\(calorieGoal)")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .padding()
                .background(
                    ZStack {
                        Circle()
                            .stroke(Color.gray, lineWidth: 12)
                        Circle()
                            .trim(from: 0.0, to: circleProgress)
                            .stroke(Color.green, style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                    }
                )
                .frame(width: 200, height: 200)
                .padding()
                .onAppear {
                    startCircleAnimation()
                }

                VStack {
                    Text("Calories brûlées")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("\(caloriesBurned)")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                )
                .padding()
                .onAppear {
                    updateCircleProgress()
                }

                if showCongratulations {
                    Text("Félicitations ! Objectif atteint !")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        )
                }
                
                VStack {
                    Text("Nouvel objectif calorique")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextField("Entrez l'objectif", text: $newCalorieGoal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                }

                Button(action: {
                    if let goal = Int(newCalorieGoal) {
                        calorieGoal = goal
                    }

                    let randomBurnedCalories = Int.random(in: 100...200)
                    caloriesBurned += randomBurnedCalories

                    if caloriesBurned >= calorieGoal {
                        showCongratulations = true
                    }

                    updateCircleProgress()
                }) {
                    Text("Ajouter des calories brûlées")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(20)
            .foregroundColor(.primary)
        }
        .navigationTitle("Défis")
    }
    
    private func startCircleAnimation() {
        withAnimation(.easeInOut(duration: 1.5)) {
            circleProgress = 1.0
        }
    }

    private func updateCircleProgress() {
        let progress = CGFloat(caloriesBurned) / CGFloat(calorieGoal)
        withAnimation(.easeInOut(duration: 0.5)) {
            circleProgress = progress
        }
    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
