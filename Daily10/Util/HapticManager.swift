//
//  HapticManager.swift
//  PresentationLayer
//
//  Created by 김호성 on 2024.07.24.
//

import Foundation
import UIKit

@MainActor
class HapticManager {
    
    private let style: UIImpactFeedbackGenerator.FeedbackStyle
    private let generator: UIImpactFeedbackGenerator
    
    static let shared = HapticManager()
    
    private init() {
        style = UIImpactFeedbackGenerator.FeedbackStyle.light
        generator = UIImpactFeedbackGenerator(style: style)
    }
    
    func generate() {
        generator.impactOccurred()
    }
}
