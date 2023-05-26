import SwiftUI

struct WorkoutsView: View {
    @State private var muscleWorkouts: [MuscleWorkout] = [
        MuscleWorkout(muscle: "Pectoraux", program: "Lundi : Développé couché - 4 séries de 10 répétitions", restTime: "Temps de repos : 1 minute", icon: "pecs"),
        MuscleWorkout(muscle: "Dos", program: "Mardi : Tractions - 4 séries de 8 répétitions", restTime: "Temps de repos : 2 minutes", icon: "back"),
        MuscleWorkout(muscle: "Jambes", program: "Mercredi : Squats - 3 séries de 12 répétitions", restTime: "Temps de repos : 1.5 minutes", icon: "legs"),
        // Ajoutez des programmes pour d'autres muscles ici
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(muscleWorkouts) { workout in
                HStack(spacing: 20) {
                    Image(systemName: workout.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                        .frame(width: 80, height: 80)
                        .background(Color.white)
                        .cornerRadius(40)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(workout.muscle)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(workout.program)
                            .font(.subheadline)
                        
                        Text(workout.restTime)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                )
                .padding(.horizontal, 20)
            }
        }
    }
}

struct MuscleWorkout: Identifiable {
    let id = UUID()
    let muscle: String
    let program: String
    let restTime: String
    let icon: String
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
