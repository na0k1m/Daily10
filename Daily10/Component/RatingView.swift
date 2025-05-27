//
//  RatingView.swift
//  PresentationLayer
//
//  Created by 김호성 on 2025.03.31.
//

import UIKit

@IBDesignable class RatingView: UIView {
    
    weak var delegate: RatingViewDelegate?
    
    private let stackView: UIStackView = UIStackView()
    private let starViews: [StarView] = [
        StarView(),
        StarView(),
        StarView(),
        StarView(),
        StarView(),
    ]
    
    var score: Int {
        get {
            return Int(star * 2)
        }
        
        set {
            return star = Float(newValue) / 2
        }
    }
    
    private var star: Float = 0 {
        didSet {
            starDidSet()
        }
    }
    private func starDidSet() {
        starViews.enumerated().forEach({ index, starView in
            starView.fill = max(0, min(star-Float(index), 1))
        })
    }
    
    @IBInspectable var accentColor: UIColor? {
        didSet {
            accentColorDidSet()
        }
    }
    private func accentColorDidSet() {
        starViews.forEach({ starView in
            starView.accentColor = accentColor
        })
    }
    
    @IBInspectable var baseColor: UIColor? {
        didSet {
            baseColorDidSet()
        }
    }
    private func baseColorDidSet() {
        starViews.forEach({ starView in
            starView.baseColor = baseColor
        })
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initializeView()
    }
    
    private func initializeView() {
        starDidSet()
        accentColorDidSet()
        baseColorDidSet()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(recognizer: )))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tapGestureHandler(recognizer: )))
        tapGestureRecognizer.minimumPressDuration = 0
        tapGestureRecognizer.delegate = self
        addGestureRecognizer(tapGestureRecognizer)
        
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        starViews.forEach({ starView in
            stackView.addArrangedSubview(starView)
        })
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func animateStar(star: Float) {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.starViews.forEach({ starView in
                starView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            if 0 < star && star <= 5 {
                self?.starViews[Int(ceil(star))-1].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        })
    }
    // MARK: - PanGesture
    @objc private func panGestureHandler(recognizer: UIPanGestureRecognizer) {
        gestureHandler(recognizer: recognizer)
    }
    
    // MARK: - TapGesture
    @objc private func tapGestureHandler(recognizer: UITapGestureRecognizer) {
        gestureHandler(recognizer: recognizer)
    }
    
    private func gestureHandler(recognizer: UIGestureRecognizer) {
        let discreteStar: Float = Float(Int(recognizer.location(in: self).x / self.bounds.width * 10)+1) / 2.0
        let rangedStar: Float = max(0, min(discreteStar, 5))
        
        switch recognizer.state {
        case .began:
            HapticManager.shared.generate()
            animateStar(star: discreteStar)
            delegate?.valueChanged(Int(rangedStar*2))
        case .changed:
            if rangedStar != star {
                HapticManager.shared.generate()
                animateStar(star: discreteStar)
                delegate?.valueChanged(Int(rangedStar*2))
            }
        case .ended:
            animateStar(star: 0)
            delegate?.valueChanged(Int(rangedStar*2))
        default:
            break
        }
        
        star = rangedStar
    }
}

extension RatingView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizers?.contains(otherGestureRecognizer) ?? false
    }
}

@MainActor
protocol RatingViewDelegate: AnyObject {
    func valueChanged(_ value: Int)
}
