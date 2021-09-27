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
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable open var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable open var externalLayerBorderWidth: CGFloat {
        get { return externalLayer.borderWidth }
        set { externalLayer.borderWidth = newValue }
    }
    
    @IBInspectable open var externalLayerBorderColor: UIColor {
        get { return UIColor(cgColor: externalLayer.borderColor ?? UIColor.white.cgColor) }
        set { externalLayer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable open var spacing: CGFloat {
        get { return self._spacing }
        set { self._spacing = newValue }
    }
    
    // MARK: - UI Property
    
    private let externalLayer: CALayer = CALayer()
    
    // MARK: - Property
    
    /// Spacing between externalLayerBorder and view
    private var _spacing: CGFloat = 0
    
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
        configureSecondLayer()
    }
    
    // MARK: - Hepler
    
    private func configureSecondLayer() {
        clipsToBounds = false
        externalLayer.frame = CGRect(x: bounds.origin.x - spacing, y: bounds.origin.y - spacing, width: frame.width + spacing * 2, height: frame.height + spacing * 2)
        let cornerRadiusPro = layer.cornerRadius / frame.width
        externalLayer.cornerRadius = externalLayer.frame.width * cornerRadiusPro
        self.layer.insertSublayer(externalLayer, above: self.layer)
    }
}
