import UIKit

class NotificationView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Appel de la fonction pour afficher les différentes notifications
        afficherNotifications()
    }
    
    func afficherNotifications() {
        // Notification : Bienvenue sur l'application KB-FIT
        afficherNotification(message: "Bienvenue sur l'application KB-FIT")
        
        // Notification : Merci d'avoir renouvelé l'abonnement
        afficherNotification(message: "Merci d'avoir renouvelé l'abonnement")
        
        // Notification : Super, vous avez atteint vos objectifs journaliers
        afficherNotification(message: "Super, vous avez atteint vos objectifs journaliers")
    }
    
    func afficherNotification(message: String) {
        let notificationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        notificationLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        notificationLabel.textColor = UIColor.white
        notificationLabel.textAlignment = .center
        notificationLabel.font = UIFont.systemFont(ofSize: 16)
        notificationLabel.text = message
        notificationLabel.alpha = 0
        
        self.view.addSubview(notificationLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            notificationLabel.alpha = 1
        }, completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseInOut, animations: {
                notificationLabel.alpha = 0
            }, completion: { (_) in
                notificationLabel.removeFromSuperview()
            })
        })
    }
}
