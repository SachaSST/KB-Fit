import SwiftUI

struct ProfileView: View {
    @State private var isShowingImagePicker = false
    @State private var profileImage: UIImage? = nil
    @State private var isPremium = true
    // Mettez à jour cette variable en fonction de l'état Premium de l'utilisateur
    
    @State private var friendsOnline: [String] = ["Ami 1", "Ami 2", "Ami 3"]
    @State private var newFriendName = ""

    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    HStack {
                        Text("Changer la photo de profil")
                            .font(.headline)
                        Spacer()
                        if let profileImage = profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                    }
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: {
                    isShowingImagePicker = false
                }, content: {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        profileImage = image
                    }
                })
                
                Section(header: Text("Amis en ligne")) {
                    ForEach(friendsOnline, id: \.self) { friend in
                        Text(friend)
                    }
                    
                    HStack {
                        TextField("Nom de l'ami", text: $newFriendName)
                        Button(action: {
                            friendsOnline.append(newFriendName)
                            newFriendName = ""
                        }) {
                            Text("Ajouter")
                        }
                    }
                }
                
                NavigationLink(destination: SubscriptionPlansView()) {
                    Text("Changer le plan d'abonnement")
                        .font(.headline)
                }
                
                Button(action: {
                    // Ajoutez la logique de déconnexion ici
                }) {
                    Text("Déconnexion")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
                if isPremium {
                    HStack {
                        Text("Inviter un ami")
                            .font(.headline)
                        Spacer()
                        Text("Premium")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
            .navigationTitle("Paramètres du profil")
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    let sourceType: UIImagePickerController.SourceType
    let completionHandler: (UIImage) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler: completionHandler)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let completionHandler: (UIImage) -> Void

        init(completionHandler: @escaping (UIImage) -> Void) {
            self.completionHandler = completionHandler
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                completionHandler(image)
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
