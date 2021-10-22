//
//  DoubleLayerView.swift
//  Pods
//
//  Created by YooBin Jo on 2021/09/26.
//

import UIKit

@IBDesignable
@available(iOS 13.0, *)
open class DoubleLayerView: UIView {
    
    // MARK: - IBInspectable
    
    @IBInspectable open var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable open var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            updateCornerRadius()
        }
    }
    
    @IBInspectable open var borderSpacing: CGFloat {
        get { return _borderSpacing }
        set {
            _borderSpacing = newValue
            updateBorderSpacing()
        }
    }
    
    @IBInspectable open var innerBackgroundColor: UIColor {
        get { return _innerBackgroundColor ?? .clear }
        set {
            _innerBackgroundColor = newValue
            updateInnerBackgroundColor()
        }
    }
    
    @IBInspectable open var isCircular: Bool {
        get { return _isCircular }
        set {
            _isCircular = newValue
            updateCornerRadius()
        }
    }
    
    // MARK: - UI Property
    
    private let innerLayer = CALayer()
    
    // MARK: - Property
    
    private var _borderSpacing: CGFloat = 0
    private var _innerBackgroundColor: UIColor?
    private var _isCircular: Bool = false
    private var innerLayerCornerRadius: CGFloat {
        get { return cornerRadius - (borderWidth * 2) }
    }
    private var isSquare: Bool {
        get {
            if frame.width == frame.height {
                return true
            } else {
                return false
            }
        }
    }
    
    // MARK: - Initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        configureInnerLayer()
    }
    
    // MARK: - Mehotd
    
    private func configureInnerLayer() {
        backgroundColor = .clear
        
        innerLayer.removeFromSuperlayer()
        updateInnerBackgroundColor()
        updateBorderSpacing()
        updateCornerRadius()
        
        layer.addSublayer(innerLayer)
    }
    
    private func updateBorderSpacing() {
        innerLayer.frame = CGRect(x: 0, y: 0,
                                  width: frame.width - _borderSpacing - (borderWidth * 2),
                                  height: frame.height - _borderSpacing - (borderWidth * 2))
        innerLayer.position = CGPoint(x: centerX, y: centerY)
    }
    
    private func updateCornerRadius() {
        if isCircular && isSquare {
            layer.cornerRadius = frame.width / 2
            innerLayer.cornerRadius = innerLayer.frame.width / 2
        } else {
            innerLayer.cornerRadius = innerLayerCornerRadius
        }
    }
    
    private func updateInnerBackgroundColor() {
        innerLayer.backgroundColor = innerBackgroundColor.cgColor
    }
}

// MARK: - Extension

extension UIView {
    var centerX: CGFloat {
        return frame.width / 2
    }
    
    var centerY: CGFloat {
        return frame.height / 2
    }
}
