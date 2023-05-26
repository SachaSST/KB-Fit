import SwiftUI

struct NutritionView: View {
    @State private var isChefAvailable = false
    @State private var selectedChef: Chef?
    @State private var isContactSheetPresented = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    CategoryView(category: "Sèche Alimentaire", meals: dryMeals)
                    
                    CategoryView(category: "Prise de Masse", meals: massMeals)
                    
                    ChefAvailabilityView(isChefAvailable: $isChefAvailable, selectedChef: $selectedChef)
                        .onTapGesture {
                            if isChefAvailable {
                                isContactSheetPresented = true
                            }
                        }
                }
                .padding()
                .navigationBarTitle("Nutrition")
                .sheet(isPresented: $isContactSheetPresented) {
                    if let chef = selectedChef {
                        ContactChefView(chef: chef)
                    }
                }
            }
        }
    }
}

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView()
    }
}

struct Meal: Identifiable {
    let id = UUID()
    let name: String
    let ingredients: [Ingredient]
}

struct Ingredient: Identifiable {
    let id = UUID()
    let name: String
    let kcal: Int
}

struct CategoryView: View {
    let category: String
    let meals: [Meal]
    
    var body: some View {
        VStack(spacing: 10) {
            Text(category)
                .font(.title)
                .fontWeight(.bold)
            
            ForEach(meals) { meal in
                VStack(alignment: .leading, spacing: 5) {
                    Text(meal.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    ForEach(meal.ingredients) { ingredient in
                        Text("- \(ingredient.name): \(ingredient.kcal) kcal")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

let dryMeals: [Meal] = [
    Meal(
        name: "Poulet Grillé avec Légumes",
        ingredients: [
            Ingredient(name: "Poulet", kcal: 150),
            Ingredient(name: "Courgette", kcal: 30),
            Ingredient(name: "Poivron", kcal: 20),
            Ingredient(name: "Brocoli", kcal: 25)
        ]
    ),
    Meal(
        name: "Salade de Quinoa aux Légumes",
        ingredients: [
            Ingredient(name: "Quinoa", kcal: 120),
            Ingredient(name: "Tomate", kcal: 15),
            Ingredient(name: "Concombre", kcal: 10),
            Ingredient(name: "Poivron", kcal: 20)
        ]
    )
]

let massMeals: [Meal] = [
    Meal(
        name: "Steak avec Pommes de Terre",
        ingredients: [
            Ingredient(name: "Steak", kcal: 250),
            Ingredient(name: "Pomme de terre", kcal: 150),
            Ingredient(name: "Haricots verts", kcal: 30)
        ]
    ),
    Meal(
        name: "Smoothie Protéiné",
        ingredients: [
            Ingredient(name: "Lait d'amande", kcal: 60),
            Ingredient(name: "Banane", kcal: 90),
            Ingredient(name: "Épinards", kcal: 10),
            Ingredient(name: "Poudre de protéine", kcal: 120)
        ]
    )
]

struct Chef: Identifiable {
    let id = UUID()
    let name: String
    let schedule: String
    let rating: Int
    let profileImageName: String
}

let chefs: [Chef] = [
    Chef(name: "Chef 1", schedule: "8:00 AM - 4:00 PM", rating: 4, profileImageName: "coach1"),
    Chef(name: "Chef 2", schedule: "9:00 AM - 5:00 PM", rating: 5, profileImageName: "coach2"),
    Chef(name: "Chef 3", schedule: "10:00 AM - 6:00 PM", rating: 3, profileImageName: "coach3")
]

struct ChefAvailabilityView: View {
    @Binding var isChefAvailable: Bool
    @Binding var selectedChef: Chef?
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Chef à disposition pour préparer les plats")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Toggle(isOn: $isChefAvailable) {
                Text("Chef disponible")
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 10)
            
            if isChefAvailable {
                Text("Sélectionnez un chef pour le contacter.")
                    .foregroundColor(.blue)
                    .font(.subheadline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(chefs) { chef in
                            ChefCardView(chef: chef)
                                .onTapGesture {
                                    selectedChef = chef
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct ChefCardView: View {
    let chef: Chef
    
    var body: some View {
        VStack(spacing: 10) {
            Image(chef.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text(chef.name)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(chef.schedule)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 5) {
                ForEach(1...chef.rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color(.gray).opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

struct ContactChefView: View {
    let chef: Chef
    
    var body: some View {
        VStack {
            Image(chef.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            
            Text(chef.name)
                .font(.title)
                .fontWeight(.bold)
            
            Text("Disponibilité: \(chef.schedule)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack(spacing: 5) {
                Text("Note:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                ForEach(1...chef.rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding(.vertical)
            
            Button(action: {
                // Code pour contacter le chef
            }) {
                Text("Contacter le chef")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
