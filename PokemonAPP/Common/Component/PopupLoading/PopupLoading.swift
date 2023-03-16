//
//  PopupLoading.swift
//  PokemonAPP
//
//  Created by Macbook on 16/03/23.
//

import UIKit
import Lottie

/// Can be used as loading indicator while fetching data on BE.
/// Go check sample use is at the end of this class
/// - Initialize this class with `UIView` on which it will appear on
/// - call function `show()` to show the loading animation.
/// - call function `dismiss()` to dismiss the loading animation and remove it from `superView`.
class PopUpLoading {
    
    private let widthHeight: CGFloat = 80
    private var parentView: UIView
    private var animationView = LottieAnimationView(name: "pokemon-loading")
    private var backgroundCover: UIView
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.pokemonBrightCoral1
        label.font = UIFont(name: "Futura", size: 15.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    init(on view: UIView) {
        self.parentView = view
        animationView.alpha = 0.3
        animationView.isHidden = true
        self.backgroundCover = UIView()
        self.backgroundCover.backgroundColor = .clear
        self.label.text = "loading"
    }
    
    deinit {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.removeObserver(self, name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        }
    }
    
    private func animateView() {
        animationView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIViewPropertyAnimator(
            duration: 0.3,
            dampingRatio: 0.6) { [weak self] () in
                guard let self = self else { return }
                self.animationView.isHidden = false
                self.animationView.alpha = 1
                self.animationView.transform = .identity
            } .startAnimation()
    }
    
    func show() {
        // swiftlint:disable line_length
        if #available(iOS 13.0, *) {
            NotificationCenter.default.removeObserver(self, name: UIScene.willEnterForegroundNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(reloadAnimation), name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(reloadAnimation), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
        // swiftlint:enable line_length
        backgroundCover.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        backgroundCover.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints =  false
        parentView.addSubview(backgroundCover)
        backgroundCover.addSubview(animationView)
        backgroundCover.addSubview(label)
        if let header = parentView.viewWithTag(99) {
            parentView.bringSubviewToFront(header)
        }
        NSLayoutConstraint.activate([
            backgroundCover.topAnchor.constraint(equalTo: parentView.topAnchor),
            backgroundCover.leftAnchor.constraint(equalTo: parentView.leftAnchor),
            backgroundCover.rightAnchor.constraint(equalTo: parentView.rightAnchor),
            backgroundCover.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            animationView.widthAnchor.constraint(equalToConstant: widthHeight),
            animationView.heightAnchor.constraint(equalToConstant: widthHeight),
            animationView.centerXAnchor.constraint(equalTo: backgroundCover.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: backgroundCover.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: backgroundCover.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 22)
        ])
        animateView()
    }
    
    func dismissAfter1() {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.removeObserver(self, name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] () in
            guard let self = self else { return }
            self.animationView.removeFromSuperview()
            self.backgroundCover.removeFromSuperview()
            self.animationView.stop()
        }
    }
    
    func dismissImmediately() {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.removeObserver(self, name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        }
        DispatchQueue.main.async { [weak self] () in
            guard let self = self else { return }
            self.animationView.removeFromSuperview()
            self.backgroundCover.removeFromSuperview()
            self.animationView.stop()
        }
    }
    
    @objc func reloadAnimation() {
        animationView.play()
    }

}

/*
 Sample Use:
 lazy var loadingIndicator = PopUpLoading(on: view)
 
 loadingIndicator.show()
 loadingIndicator.dismiss()
 
  like the sample below
  - ptv.isLoginLoading
     .drive(onNext: { [weak self] isLoading in
        if isLoading {
             self?.loadingIndicator.show()
         } else {
             self?.loadingIndicator.dismissAfter1()
         }
     })
     .disposed(by: disposeBag)
 */
