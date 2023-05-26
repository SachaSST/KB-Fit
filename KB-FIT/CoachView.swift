import Foundation
import SwiftUI



struct Coach: Identifiable {
    let id = UUID()
    let name: String
    let specialty: String
    let contactInfo: String
    let photo: String
    let description: String
    let specialties: [String]
}

struct CoachView: View {
    let coaches = [
        Coach(name: "John Doe", specialty: "Fitness", contactInfo: "john.doe@example.com", photo: "coach1", description: "Coach professionnel avec plus de 10 ans d'expérience dans le domaine du fitness.", specialties: ["Muscle Building", "Weight Loss", "Cardio"]),
        Coach(name: "Jane Smith", specialty: "Yoga", contactInfo: "jane.smith@example.com", photo: "coach2", description: "Instructeur certifié de yoga, spécialisée dans les techniques de relaxation et de méditation.", specialties: ["Hatha Yoga", "Vinyasa Flow", "Meditation"]),
        Coach(name: "Mark Johnson", specialty: "Meditation", contactInfo: "mark.johnson@example.com", photo: "coach3", description: "Expert en méditation transcendantale, formé dans les traditions orientales et occidentales.", specialties: ["Mindfulness", "Breathing Techniques", "Stress Relief"])
    ]
    
    @State private var selectedCoach: Coach?
    
    var body: some View {
        NavigationView {
            List(coaches) { coach in
                Button(action: {
                    selectedCoach = coach
                }) {
                    HStack(spacing: 16) {
                        Image(coach.photo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(coach.name)
                                .font(.headline)
                            
                            Text(coach.specialty)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            HStack(spacing: 8) {
                                ForEach(coach.specialties, id: \.self) { specialty in
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(.blue)
                                    Text(specialty)
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Text(coach.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("Coach")
            .sheet(item: $selectedCoach) { coach in
                CoachDetailsView(coach: coach)
            }
        }
    }
}

struct CoachDetailsView: View {
    let coach: Coach
    
    var body: some View {
        HStack(spacing: 16) {
            Image(coach.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(coach.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Spécialité: \(coach.specialty)")
                    .font(.headline)
                
                Text(coach.description)
                    .font(.subheadline)
                
                HStack(spacing: 8) {
                    ForEach(coach.specialties, id: \.self) { specialty in
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.blue)
                        Text(specialty)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Détails")
    }
}

struct CoachView_Previews: PreviewProvider {
    static var previews: some View {
        CoachView()
    }
}
