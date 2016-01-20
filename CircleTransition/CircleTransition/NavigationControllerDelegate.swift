//
//  NavigationControllerDelegate.swift
//  CircleTransition
//
//  Created by Dean Woodward on 20/01/16.
//  Copyright © 2016 Datacom. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {

    @IBOutlet weak var navigationController: UINavigationController?
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("panned:"))
        navigationController!.view.addGestureRecognizer(panGesture)
    }
    
    @IBAction func panned(gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began:
            interactionController = UIPercentDrivenInteractiveTransition()
            if navigationController?.viewControllers.count > 1 {
              navigationController?.popViewControllerAnimated(true)
            } else {
              navigationController?.topViewController!.performSegueWithIdentifier("PushSegue", sender: nil)
            }

        //2
        case .Changed:
            let translation = gestureRecognizer.translationInView(self.navigationController!.view)
            let completionProgress = translation.x/CGRectGetWidth(self.navigationController!.view.bounds)
            interactionController?.updateInteractiveTransition(completionProgress)

        //3
        case .Ended:
            if (gestureRecognizer.velocityInView(self.navigationController!.view).x > 0) {
              interactionController?.finishInteractiveTransition()
            } else {
              interactionController?.cancelInteractiveTransition()
            }
            interactionController = nil

        //4
        default:
            interactionController?.cancelInteractiveTransition()
            interactionController = nil
        }
    }

    
    func navigationController(navigationController: UINavigationController,
         animationControllerForOperation operation: UINavigationControllerOperation,
                         fromViewController fromVC: UIViewController,
                             toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return CircleTransitionAnimator()
    }
    
    func navigationController(navigationController: UINavigationController, 
        interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController
    }

}
