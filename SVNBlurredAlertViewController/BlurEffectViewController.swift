//
//  BlurEffectViewController.swift
//  Tester
//
//  Created by Aaron Dean Bikis on 4/7/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNModalViewController
import SVNMaterialButton
import SVNShapesManager
import SVNTheme

/*
 A blurred modal viewController intended to be added as a subview of another viewController.
 Contains a button a body and a header.
 init with a theme and SVNBlurredAlertModel instance.
 If you want to conduct a custom unwind outside of this dismissing itself reference the dismissalCallback: variable.
**/
open class SVNBlurredAlertViewController: SVNModalViewController {
  
  open lazy var checkmarkMeta: SVNShapeMetaData = {
    let shape = SVNShapeMetaData(shapes: nil,
                                 location: .topMid,
                                 padding: CGPoint(x: 0.0, y: 95.0),
                                 size: CGSize(width: 105.0, height: 105.0),
                                 fill: UIColor.clear.cgColor,
                                 stroke: self.theme.stanardButtonTintColor.cgColor,
                                 strokeWidth: 2.5)
    return shape
  }()
  
  open lazy var circleMeta: SVNShapeMetaData = {
    let shape = SVNShapeMetaData(meta: self.checkmarkMeta)
    return shape
  }()
  
  open lazy var header: UILabel = {
    let rect = self.shapesManager.fetchRect(with: self.checkmarkMeta)
    let label = UILabel(frame: CGRect(
      x: 35,
      y: rect.origin.y + rect.size.height + 15,
      width: self.view.frame.width - (35 * 2),
      height: 65))
    label.textAlignment = .center
    label.textColor = UIColor.white
    label.font = UIFont.systemFont(ofSize: 35)
    return label
  }()
  
  open var dismissalCallback: (() -> Void)?
  
  open lazy var body: UILabel = {
    let label = UILabel(frame: CGRect(
      x: 65,
      y: self.header.frame.origin.y + self.header.frame.size.height,
      width: self.view.frame.width - (65 * 2),
      height: self.acceptButton.frame.origin.y - (self.header.frame.origin.y + self.header.frame.size.height + 45)))
    label.textAlignment = .center
    label.textColor = UIColor.white
    label.font = UIFont.systemFont(ofSize: 35)
    label.numberOfLines = 0
    return label
  }()
  
  open lazy var acceptButton: SVNMaterialButton = {
    let button = SVNMaterialButton(frame: CGRect(x: SVNMaterialButton.standardPadding, y: self.view.bounds.height - (SVNMaterialButton.bottomPadding + SVNMaterialButton.standardHeight),
                                                 width: self.view.bounds.width - SVNMaterialButton.standardPadding * 2, height: SVNMaterialButton.standardHeight),
                                   viewModel: self.buttonViewModel)
    button.addTarget(self, action: #selector(SVNBlurredAlertViewController.didAccept), for: .touchUpInside)
    return button
  }()
  
  public var model: SVNBlurredAlertModel
  
  public var buttonViewModel: SVNMaterialButtonViewModel
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    setInitialView()
    setCircleCrop()
  }
  
  public init(theme: SVNTheme?, model: SVNBlurredAlertModel? = SVNBlurredAlertModel_Default(),
              buttonViewModel: SVNMaterialButtonViewModel? = SVNMaterialButtonViewModel_Default()){
    self.model = model!
    self.buttonViewModel = buttonViewModel!
    super.init(nibName: nil, bundle: nil)
    self.theme = theme == nil ? SVNTheme_DefaultDark() : theme!
    
  }
  
  public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,
              theme: SVNTheme?, model: SVNBlurredAlertModel? = SVNBlurredAlertModel_Default(),
              buttonViewModel: SVNMaterialButtonViewModel? = SVNMaterialButtonViewModel_Default()) {
    self.model = model!
    self.buttonViewModel = buttonViewModel!
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.theme = theme == nil ? SVNTheme_DefaultDark() : theme!
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("this class is does not support init(coder:) use init(), init(theme:, model:), or init(nibName: bundle: theme: model:")
  }
  
  private func setInitialView(){
    self.view.backgroundColor = UIColor.clear
    self.header.text = model.header
    self.body.text = model.body
    self.acceptButton.setTitle(model.buttonText, for: .normal)
    
  }
  
  private func setCircleCrop(){
    //Create the shapes and containers to house them
    self.checkmarkMeta.shapes = [self.shapesManager.createCheckMark(with: self.checkmarkMeta)]
    self.circleMeta.shapes = [self.shapesManager.createCircleLayer(with: self.circleMeta)]
    
    let checkView = UIView(frame: self.shapesManager.fetchRect(with: self.checkmarkMeta))
    checkView.backgroundColor = UIColor.clear
    self.view.addSubview(checkView)
    
    //Create VisualEffect
    let blurEffect = UIBlurEffect(style: .light)
    let effectView = UIVisualEffectView(effect: blurEffect)
    effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    effectView.frame = self.view.bounds
    self.view.addSubview(effectView)
    
    //Add the shapes to the containers
    checkView.layer.addSublayer(self.checkmarkMeta.shapes!.first!)
    effectView.layer.addSublayer(circleMeta.shapes!.first!)
    
    //Create a path for the mask
    let path = UIBezierPath (
      roundedRect: effectView.frame,
      cornerRadius: 0)
    
    //Create a circle for the mask to go around
    let circle = UIBezierPath(
      roundedRect: self.shapesManager.fetchRect(with: self.circleMeta),
      cornerRadius: self.circleMeta.size.width / 2)
    
    path.append(circle)
    path.usesEvenOddFillRule = true
    
    //Create a layer
    let masklayer = CAShapeLayer()
    masklayer.path = path.cgPath
    masklayer.fillRule = kCAFillRuleEvenOdd
    
    //Create the maskView
    let maskView = UIView(frame: self.view.frame)
    maskView.backgroundColor = UIColor.black
    maskView.layer.mask = masklayer
    effectView.mask = maskView
    
    //Add subviews to the effect
    effectView.addSubview(self.acceptButton)
    effectView.addSubview(self.body)
    effectView.addSubview(self.header)
  }
  
  //MARK: Actions
  open func didAccept(){
    guard dismissalCallback == nil else {
      dismissalCallback!()
      return
    }
    shouldDismiss()
  }
}
