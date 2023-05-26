import SwiftUI

struct HomeView: View {
    @State private var currentIndex = 0
    let imageNames = ["image1", "image2", "image3"]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let carouselHeight: CGFloat = 180
    let carouselWidth: CGFloat = UIScreen.main.bounds.width
    
    @State private var weight: Double = 70
    @State private var height: Double = 170
    @State private var bodyFatPercentage: Double = 20
    @State private var musclePercentage: Double = 40
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("db"))
                    
                    Spacer()
                    
                    NavigationLink(destination: NotificationsView()) {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("db"))
                    }
                }
                .padding(.horizontal, 20)
                
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: WorkoutsView()) {
                        HomeButton(title: "Workouts", imageName: "workoutsIcon", iconSystemName: "heart.circle")
                    }
                    Spacer()
                    NavigationLink(destination: ChallengesView()) {
                        HomeButton(title: "Challenges", imageName: "challengesIcon", iconSystemName: "flame.fill")
                    }
                    Spacer()
                }
                .padding(.top)
                
                HStack {
                    Spacer()
                    NavigationLink(destination: CoachView()) {
                        HomeButton(title: "Coach", imageName: "coachIcon", iconSystemName: "person.2.circle.fill")
                    }
                    Spacer()
                    NavigationLink(destination: NutritionView()) {
                        HomeButton(title: "Nutrition", imageName: "nutritionIcon", iconSystemName: "leaf.fill")
                    }
                    Spacer()
                }
                .padding(.top)
                
                Spacer()
                
                TabView(selection: $currentIndex) {
                    ForEach(0..<imageNames.count, id: \.self) { index in
                        Image(imageNames[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: carouselWidth, height: carouselHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 36))
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(width: carouselWidth, height: carouselHeight)
                .padding(.bottom, 20)
                .onReceive(timer) { _ in
                    currentIndex = (currentIndex + 1) % imageNames.count
                }
                
                NavigationLink(destination: EvolutionView(weight: weight, height: height, bodyFatPercentage: bodyFatPercentage, musclePercentage: musclePercentage)) {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        Text("Your Evolution")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.headline)
                            .foregroundColor(Color(.systemGray))
                    }
                    .padding()
                    .background(Color("db"))
                    .cornerRadius(20)
                    .shadow(color: Color("db").opacity(0.5), radius: 10, x: 0, y: 10)
                    .padding(.horizontal)
                }
                .padding(.bottom, 10) // Réduire le padding en bas
                
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
    
    struct HomeButton: View {
        let title: String
        let imageName: String
        let iconSystemName: String
        
        var body: some View {
            VStack {
                Image(systemName: iconSystemName)
                    .font(.system(size: 30))
                    .foregroundColor(Color("db"))
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 20)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color(.gray).opacity(0.2), radius: 10, x: 0, y: 10)
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
    
    struct BoutiqueView: View {
        var body: some View {
            Text("Boutique View")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
    
    struct EvolutionView: View {
        let weight: Double
        let height: Double
        let bodyFatPercentage: Double
        let musclePercentage: Double
        
        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("Your Evolution")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Weight")
                            .font(.headline)
                        Text("\(weight) kg")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Height")
                            .font(.headline)
                        Text("\(height) cm")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Body Fat")
                            .font(.headline)
                        Text("\(bodyFatPercentage)%")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Muscle")
                            .font(.headline)
                        Text("\(musclePercentage)%")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
                
                Text("Evolution sous forme de graphique")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct NotificationsView: View {
    var body: some View {
        Text("Notifications View")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
}
