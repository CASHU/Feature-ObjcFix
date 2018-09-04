//
//  PopupViewController.swift
//
//  Created by Ahmed AbdEl-Samie on 12/3/17.
//
//

import Foundation
import CCMPopup

class PopupViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var rightActionButton: UIButton!
    @IBOutlet weak var leftActionButton: UIButton!
    @IBOutlet weak var containerView: UIView!

    private var rightActionButtonBlock : (() -> Void)? = nil
    private var leftActionButtonBlock : (() -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    class func showPopupInController(_ controller: UIViewController, title: String, message: String, leftButtonTitle : String, leftButtonActionBlock: (() -> Void)? = nil, rightButtonTitle : String?, rightButtonActionBlock: (() -> Void)? = nil){

        let storyboard = UIStoryboard(name: "GeneralStoryboard", bundle: Bundle(for: PopupViewController.self))
        let popupViewController = storyboard.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        popupViewController.view.alpha = 1.0

        popupViewController.titleLabel.text = title
        popupViewController.message.text = message
        popupViewController.leftActionButton.setTitle(leftButtonTitle, for: .normal)
        if(rightButtonTitle != nil){
            popupViewController.rightActionButton.setTitle(rightButtonTitle, for: .normal)
        }else{
            popupViewController.rightActionButton.removeFromSuperview()
        }



        let popup = CCMPopupTransitioning.sharedInstance()
        popup?.destinationBounds = CGRect(x: 0, y: 0, width: controller.view.frame.width, height: controller.view.frame.height)
        popup?.backgroundBlurRadius = 0.7
        popup?.backgroundViewAlpha = 0.7
        popup?.backgroundViewColor = UIColor.black
        popup?.dismissableByTouchingBackground = true
        popup?.presentedController = popupViewController
        popup?.presentingController = controller

        popupViewController.containerView.layer.cornerRadius = 26
        popupViewController.containerView.clipsToBounds = true

        popupViewController.rightActionButtonBlock = rightButtonActionBlock
        popupViewController.leftActionButtonBlock = leftButtonActionBlock
        controller.present(popupViewController, animated: true, completion: nil)

    }


    @IBAction func rightButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if(rightActionButtonBlock != nil){
            rightActionButtonBlock!()
        }
    }

    @IBAction func leftButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if(leftActionButtonBlock != nil){
            leftActionButtonBlock!()
        }
    }


}

