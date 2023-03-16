//
//  BasePopUpViewController.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import Foundation
import RxSwift
import RxGesture

class BasePopUpViewController: UIViewController {

    open var bag = DisposeBag()
    var isDraggingScroll: Bool? = false
    var contentOffsetScroll: CGFloat = 0
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.view.gestureRecognizers?.removeAll()
    }
    
    /// Must import this on child class for animate container up and add touchable dismiss Popup
    func didLoadPopup(backView: UIView, contentView: UIView, isSetupAction: Bool = true) {
        containerInitialState(contentView)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        if isSetupAction {
            setupAction(backView: backView, contentView: contentView)
        }
    }
    
    func containerInitialState(_ view: UIView) {
        view.transform = CGAffineTransform(translationX: 0, y: .currentDeviceHeight)
    }
    
    func animateContainerUp(_ view: UIView) {
        let animation = UIViewPropertyAnimator(
            duration: 0.5,
            dampingRatio: 0.8) { () in
            view.transform = .identity
        }
        animation.startAnimation()
    }
    
    func animateFadeInBackView(_ view: UIView) {
        view.alpha = 0
        UIView.animate(withDuration: 0.4) {
            view.alpha = 0.6
        }
    }
    
    func dismissPopup(backView: UIView, contentView: UIView) {
        UIView.animate(withDuration: 0.1) {
            backView.alpha = 0
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: .curveEaseInOut) { [weak self] () in
            guard let self = self else { return }
            self.containerInitialState(contentView)
        } completion: { [weak self] isDone in
            guard let self = self else { return }
            if isDone {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
}

extension BasePopUpViewController {
    private func setupAction(backView: UIView, contentView: UIView) {
        
        backView.rx.tapGesture()
            .when(.recognized)
            .map { _ in () }
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.dismissPopup(backView: backView, contentView: contentView)
            }
            .disposed(by: bag)
        
        let fullFrameContent = contentView.frame.height
        let halfFrameContent = fullFrameContent / 2
        
        contentView.rx.panGesture()
            .when(.changed)
            .asTranslation()
            .subscribe(onNext: { [weak self] translation, _ in
                guard let self = self else { return }
                if self.isDraggingScroll! {
                    if self.contentOffsetScroll == 0 {
                        let newHeight = translation.y
                        if newHeight > 0 && newHeight < fullFrameContent {
                            // Update transform when dragging
                            contentView.transform = CGAffineTransform(translationX: 0, y: newHeight)
                            self.view.layoutIfNeeded()
                        }
                    }
                } else {
                    let newHeight = translation.y
                    if newHeight > 0 && newHeight < fullFrameContent {
                        // Update transform when dragging
                        contentView.transform = CGAffineTransform(translationX: 0, y: newHeight)
                        self.view.layoutIfNeeded()
                    }
                }
            })
            .disposed(by: bag)
        
        contentView.rx.panGesture()
            .when(.ended)
            .asTranslation()
            .subscribe(onNext: { [weak self] translation, _ in
                guard let self = self else { return }
                let newHeight = translation.y
                if newHeight < halfFrameContent {
                    self.animateContainerUp(contentView)
                } else if newHeight > halfFrameContent && newHeight < fullFrameContent {
                    self.dismissPopup(backView: backView, contentView: contentView)
                }
            })
            .disposed(by: bag)
    }
}
