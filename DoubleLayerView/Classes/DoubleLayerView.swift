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
    
    // MARK: - UI Property
    
    private let innerLayer = CALayer()
    
    // MARK: - Property
    
    private var _borderSpacing: CGFloat = 0
    private var _innerBackgroundColor: UIColor?
    private var cornerRadiusProportion: CGFloat {
        get { return self.layer.cornerRadius / self.frame.width }
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
//        innerLayer.drawsAsynchronously = true
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
                                  width: frame.width - _borderSpacing - borderWidth,
                                  height: frame.height - _borderSpacing - borderWidth)
        innerLayer.position = CGPoint(x: centerX, y: centerY)
    }
    
    private func updateCornerRadius() {
        innerLayer.cornerRadius = innerLayer.frame.width * cornerRadiusProportion
    }
    
    private func updateInnerBackgroundColor() {
        innerLayer.backgroundColor = innerBackgroundColor.cgColor
    }
    
    /// Just test. We have to refactor this method
    open func changeProperty() {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            print("Something")
        }
        CATransaction.setAnimationDuration(5)
        
        cornerRadius = 20
        borderSpacing = 20
        borderWidth = 10
        borderColor = .blue

        UIView.animate(withDuration: 1) {
            self.layoutIfNeeded()
        }
        
        let backgroundAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderColor))
        backgroundAnimation.fromValue = UIColor.systemGreen.cgColor
        backgroundAnimation.toValue = UIColor.blue.cgColor
        
        let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerAnimation.fromValue = 8
        cornerAnimation.toValue = 20
        
        let borderWidthAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        borderWidthAnimation.fromValue = 4
        borderWidthAnimation.toValue = 10
        
        let innerCornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerAnimation.fromValue = 8
        cornerAnimation.toValue = innerLayer.frame.width * cornerRadiusProportion
        
        let boundsAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.frame))
        boundsAnimation.fromValue = innerLayer.frame
        boundsAnimation.toValue = CGRect(x: 0, y: 0,
                                         width: frame.width - _borderSpacing - borderWidth,
                                         height: frame.height - _borderSpacing - borderWidth)

        
        self.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius))
        self.layer.add(backgroundAnimation, forKey: #keyPath(CALayer.borderColor))
        self.layer.add(borderWidthAnimation, forKey: #keyPath(CALayer.borderWidth))
        
        innerLayer.add(innerCornerAnimation, forKey: #keyPath(CALayer.cornerRadius))
        innerLayer.add(boundsAnimation, forKey: #keyPath(CALayer.frame))

        CATransaction.commit()
    }
}

