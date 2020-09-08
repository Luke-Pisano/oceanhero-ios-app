//
//  DaxOnboardingViewController.swift
//  DuckDuckGo
//
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit

enum OnboardingStep: Int, CaseIterable {
    case first = 0
    case second = 1
    case third = 2
    
    init(value: Int) {
        self = OnboardingStep(rawValue: value) ?? .first
    }
}

class DaxOnboardingViewController: UIViewController, Onboarding {
    struct Constants {
        static let animationDelay = 1.4
        static let animationDuration = 0.4
    }
    
    weak var delegate: OnboardingDelegate?
    weak var daxDialog: DaxDialogViewController?
    
    @IBOutlet weak var imagesScrollView: UIScrollView!
    @IBOutlet weak var textScrollView: UIScrollView!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    @IBOutlet weak var onboardingImageFirst: UIImageView!
    @IBOutlet weak var onboardingImageSecond: UIImageView!
    @IBOutlet weak var onboardingImageThird: UIImageView!
    
    @IBOutlet weak var onboardingTextFirst: UILabel!
    @IBOutlet weak var onboardingTextSecond: UILabel!
    @IBOutlet weak var onboardingTextThird: UILabel!
    
    @IBOutlet weak var textScrollViewBackground: UIView!
    
    @IBOutlet weak var pageControl: CustomPageControl!
    
    private var currentStep = OnboardingStep.first {
        didSet {
            pageControl.currentPage = currentStep.rawValue
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return isPad ? super.supportedInterfaceOrientations : [ .portrait ]
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return isPad ? super.preferredInterfaceOrientationForPresentation : .portrait
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeStep(for: size.width)
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onboardingTextFirst.htmlBold(text: UserText.daxOnBoardingTextFirst)
        onboardingTextSecond.htmlBold(text: UserText.daxOnBoardingTextSecond)
        onboardingTextThird.htmlBold(text: UserText.daxOnBoardingTextThird)
        
        textScrollViewBackground.layer.cornerRadius = 50
        textScrollViewBackground.layer.masksToBounds = true
        
        continueButton.layer.cornerRadius = 25
        continueButton.layer.masksToBounds = true
        
        imagesScrollView.contentOffset.x = 0.0
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        
        if let controller = segue.destination as? DaxDialogViewController {
            self.daxDialog = controller
        } else if let controller = segue.destination as? DaxOnboardingPadViewController {
            controller.delegate = self
        } else if let controller = segue.destination as? OnboardingViewController {
            controller.delegate = self
        }
    }
    
    @objc
    func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left && currentStep.rawValue + 1 < OnboardingStep.allCases.count {
            currentStep = OnboardingStep(value: currentStep.rawValue + 1)
            changeStep(for: view.frame.size.width)
        }
            
        if sender.direction == .right && currentStep.rawValue - 1 >= 0 {
            currentStep = OnboardingStep(value: currentStep.rawValue - 1)
            changeStep(for: view.frame.size.width)
        }
    }
    
    @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
        currentStep = OnboardingStep(value: sender.currentPage)
        changeStep(for: view.frame.size.width)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        switch currentStep {
        case .first:
            currentStep = .second
            changeStep(for: view.frame.size.width)
            
        case .second:
            currentStep = .third
            changeStep(for: view.frame.size.width)
            
        case .third:
            onboardingCompleted(controller: self)
            return
        }
    }
    
    @IBAction func skipButtonTouched(_ sender: Any) {
        onboardingCompleted(controller: self)
    }
    
    @IBAction func onTapButton() {
        let segue = isPad ? "AddToHomeRow-iPad" : "AddToHomeRow"
        performSegue(withIdentifier: segue, sender: self)
    }
    
    private func changeStep(for width: CGFloat) {
        switch currentStep {
        case .first:
            scrollViewAnimation(imageTargetPosition: 0.0, textTargetPosition: 0.0)
            continueButton.setTitle(UserText.daxOnBoardingButtonFirst, for: UIControl.State.normal)
        
        case .second:
            scrollViewAnimation(imageTargetPosition: width, textTargetPosition: width)
            continueButton.setTitle(UserText.daxOnBoardingButtonSecond, for: UIControl.State.normal)
            
        case .third:
            scrollViewAnimation(imageTargetPosition: width * 2, textTargetPosition: width * 2)
            continueButton.setTitle(UserText.daxOnBoardingButtonThird, for: UIControl.State.normal)
        }
    }
    
    private func scrollViewAnimation(imageTargetPosition: CGFloat, textTargetPosition: CGFloat) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.imagesScrollView.contentOffset.x = imageTargetPosition
                self.textScrollView.contentOffset.x = textTargetPosition
            }, completion: nil)
        }
    }
}

extension DaxOnboardingViewController: OnboardingDelegate {
    func onboardingCompleted(controller: UIViewController) {
        controller.dismiss(animated: true)
        self.delegate?.onboardingCompleted(controller: self)
    }
}

extension UIPageControl {
    func customPageControl(dotFillColor: UIColor, dotBorderColor: UIColor, dotBorderWidth: CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            } else {
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            }
        }
    }

}
