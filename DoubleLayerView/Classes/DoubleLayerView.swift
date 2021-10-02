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
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable open var borderSpacing: CGFloat {
        get { return _borderSpacing }
        set { _borderSpacing = newValue }
    }
    
    open override var backgroundColor: UIColor? {
        willSet {
            _backgroundColor = backgroundColor
        }
    }
    
    private var cornerRadiusProportion: CGFloat {
        get { return self.layer.cornerRadius / self.frame.width }
    }
    
    // MARK: - UI Property
    
    private let innerLayer:CALayer = CALayer()
    
    // MARK: - Property
    
    private var _borderSpacing: CGFloat = 0
    private var _buttonColor: UIColor?
    private var _backgroundColor: UIColor?
    
    // MARK: - Initializer
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        configureInnerLayer()
    }
    
    // MARK: - Method
    
    private func configureInnerLayer() {
        clipsToBounds = false
        _backgroundColor = backgroundColor
        backgroundColor = .clear
        
        innerLayer.removeFromSuperlayer()
        innerLayer.frame = CGRect(x: 0, y: 0,
                                  width: frame.width - _borderSpacing - borderWidth,
                                  height: frame.height - _borderSpacing - borderWidth)
        innerLayer.position = CGPoint(x: centerX, y: centerY)
        innerLayer.backgroundColor = _backgroundColor?.cgColor
        innerLayer.cornerRadius = innerLayer.frame.width * cornerRadiusProportion
        
        layer.addSublayer(innerLayer)
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
