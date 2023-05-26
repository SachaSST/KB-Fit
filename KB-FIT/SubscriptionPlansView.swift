import SwiftUI

struct SubscriptionPlansView: View {
    @State private var isLoading = false
    @State private var isPaymentCompleted = false
    @State private var selectedPlan: SubscriptionPlan?

    var body: some View {
        ZStack {
            Color("white").edgesIgnoringSafeArea(.all)
            
            List {
                SubscriptionPlanView(
                    title: "Basique",
                    price: "19,99 €",
                    benefits: ["Accès aux salles standard"],
                    action: {
                        handlePlanSelection(plan: SubscriptionPlan(title: "Basique", price: "19,99 €", benefits: ["Accès aux salles standard"]))
                    }
                )
                SubscriptionPlanView(
                    title: "Premium",
                    price: "29,99 €",
                    benefits: [
                        "Nourriture et boissons gratuites",
                        "Accès aux salles en Europe",
                        "Accès aux salles premium"
                    ],
                    titleColor: .yellow,
                    isTitleItalic: false,
                    action: {
                        handlePlanSelection(plan: SubscriptionPlan(title: "Premium", price: "29,99 €", benefits: [
                            "Nourriture et boissons gratuites",
                            "Accès aux salles en Europe",
                            "Accès aux salles premium"
                        ]))
                    }
                )
                SubscriptionPlanView(
                    title: "Ultimate",
                    price: "39,99 €",
                    benefits: [
                        "Nourriture et boissons gratuites",
                        "Accès aux salles en Europe",
                        "Accès aux salles premium",
                        "Coach personnel gratuit"
                    ],
                    titleColor: Color.blue,
                    isTitleItalic: true,
                    action: {
                        handlePlanSelection(plan: SubscriptionPlan(title: "Ultimate", price: "39,99 €", benefits: [
                            "Nourriture et boissons gratuites",
                            "Accès aux salles en Europe",
                            "Accès aux salles premium",
                            "Coach personnel gratuit"
                        ]))
                    }
                )
            }
            .listStyle(PlainListStyle())
            .background(Color.clear)
            .navigationTitle("Plans d'abonnement")
            .alert(isPresented: $isPaymentCompleted, content: {
                Alert(
                    title: Text("Paiement validé"),
                    message: Text(paymentConfirmationMessage(for: selectedPlan)),
                    dismissButton: .default(Text("OK"))
                )
            })
        }
    }

    func handlePlanSelection(plan: SubscriptionPlan) {
        isLoading = true

        // Simulate payment processing delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            selectedPlan = plan
            isLoading = false
            isPaymentCompleted = true
        }
    }
    
    func paymentConfirmationMessage(for plan: SubscriptionPlan?) -> String {
        guard let plan = plan else { return "" }
        let nextBillingDate = Calendar.current.date(byAdding: .month, value: 1, to: Date()) ?? Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let formattedDate = formatter.string(from: nextBillingDate)
        
        return "Votre achat d'un abonnement \(plan.title) au prix de \(plan.price) a été effectué avec succès. Votre abonnement se renouvellera automatiquement le \(formattedDate)."
    }
}

struct SubscriptionPlanView: View {
    let title: String
    let price: String
    let benefits: [String]
    let titleColor: Color?
    let isTitleItalic: Bool
    let action: () -> Void

    init(title: String, price: String, benefits: [String], titleColor: Color? = nil, isTitleItalic: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.price = price
        self.benefits = benefits
        self.titleColor = titleColor
        self.isTitleItalic = isTitleItalic
        self.action = action
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Plan ")
                    .font(.headline)
                Text(title)
                    .font(.headline)
                    .foregroundColor(titleColor)
                    .italic(isTitleItalic)
                Spacer()
                Text(price)
                    .font(.headline)
            }

            ForEach(benefits, id: \.self) { benefit in
                Text("• \(benefit)")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .onTapGesture {
            action()
        }
    }
}

struct SubscriptionPlansView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionPlansView()
    }
}

struct SubscriptionPlan: Identifiable {
    let id = UUID()
    let title: String
    let price: String
    let benefits: [String]
}
