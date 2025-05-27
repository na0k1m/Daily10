//
//  StarView.swift
//  PresentationLayer
//
//  Created by 김호성 on 2025.03.31.
//

import UIKit

class StarView: UIView {
    
    public let starImageView: UIImageView = UIImageView()
    
    var accentColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    var baseColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var fill: Float? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initializeView()
    }
    
    private func initializeView() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.contentMode = .scaleAspectFit
        starImageView.image = UIImage(resource: .dsstar)
        addSubview(starImageView)
        
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: topAnchor),
            starImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starImageView.widthAnchor.constraint(equalTo: heightAnchor),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mask = starImageView
    }
    
    override func draw(_ rect: CGRect) {
        guard let accentColor = accentColor, let baseColor = baseColor, let fill = fill else { return }
        let width = rect.width
        let height = rect.height
        
        let backgroundRect = CGRect(x: 0, y: 0, width: width, height: height)
        let backgroundPath = UIBezierPath(rect: backgroundRect)
        baseColor.setFill()
        backgroundPath.fill()
        
        let fillRect = CGRect(x: 0, y: 0, width: CGFloat(fill)*width, height: height)
        let fillPath = UIBezierPath(rect: fillRect)
        accentColor.setFill()
        fillPath.fill()
    }
}
