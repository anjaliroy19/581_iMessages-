import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   func displayMessageInterface() {
    let composeVC = MFMessageComposeViewController()
    composeVC.messageComposeDelegate = self
    
   
    composeVC.recipients = ["3142026521"]
    composeVC.body = "I love EECS581!"
    
    
    if MFMessageComposeViewController.canSendText() {
        self.present(composeVC, animated: true, completion: nil)
    } else {
        print("Can't send messages.")
    }
}
}
