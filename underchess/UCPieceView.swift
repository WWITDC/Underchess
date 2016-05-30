//
//  UCPieceView.swift
//  Underchess
//
//  Created by Apollonian on 3/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

protocol UCPieceViewDelegate{
    func getError(error: ErrorType)
    func touchUpInside(tag: Int) throws
//    func touchesMovedToDirection()
    
}

@IBDesignable class UCPieceView: UIView {
    
    var currentTouchMovingDirection: UCDirection?
    var delegate: UCPieceViewDelegate?
    
    init(color: UIColor){
        super.init(frame: CGRect.zero)
        backgroundColor = color
        alpha = 0
        layer.borderWidth = 5
        layer.borderColor = UIColor.whiteColor().CGColor
        setupLayers()
    }

    init(color: UIColor, strokeColor: UIColor, strokeWdith: CGFloat){
        super.init(frame: CGRect.zero)
        backgroundColor = color
        alpha = 0
        layer.borderWidth = strokeWdith
        layer.borderColor = strokeColor.CGColor
        setupLayers()
    }

    init(frame: CGRect, cornerRadius radius: CGFloat, color: UIColor, picture: UIImage?, animatable: Bool?){
        super.init(frame: frame)
        // MARK: New Feature: Customized Background
        /*
         if let image = picture{
         if let needAnimation = animatable{
         
         } else {
         
         }
         }
         */
        layer.cornerRadius = radius
        backgroundColor = color
        alpha = 0
        setupLayers()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("UCPieceView don't know about NSCoder")
    }

    func round(){
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }

//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesMoved(touches, withEvent: event)
//        
//    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if currentTouchMovingDirection == nil{
            if let handler = delegate{
                do{
                    try handler.touchUpInside(tag)
                } catch let error {
                    handler.getError(error)
                }
            }
        }
    }

    // MARK: Quartz Code exported animation
    var layers : Dictionary<String, AnyObject> = [:]
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var updateLayerValueForCompletedAnimation : Bool = false

    func setupLayers(){
        layers["self"] = self.layer
        //resetLayerPropertiesForLayerIdentifiers(nil)
    }

    //func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
        //CATransaction.begin()
        //CATransaction.setDisableActions(true)
        //CATransaction.commit()
    //}

    //MARK: - Animation Setup

    func addRainbowSparkingAnimation(){
        addRainbowSparkingAnimationCompletionBlock(nil)
    }

    func addRainbowSparkingAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 2
            completionAnim.delegate = self
            completionAnim.setValue("RainbowSparking", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"RainbowSparking")
            if let anim = layer.animationForKey("RainbowSparking"){
                completionBlocks[anim] = completionBlock
            }
        }

        let fillMode = kCAFillModeForwards

        ////Animation
        let strokeColorAnim      = CAKeyframeAnimation(keyPath:"strokeColor")
        strokeColorAnim.values   = [UIColor.whiteColor().CGColor,
                                        UIColor.redColor().CGColor,
                                        UIColor.orangeColor().CGColor,
                                        UIColor.yellowColor().CGColor,
                                        UIColor.greenColor().CGColor,
                                        UIColor.cyanColor().CGColor,
                                        UIColor.blueColor().CGColor,
                                        UIColor.purpleColor().CGColor,
                                        UIColor.whiteColor().CGColor]
        strokeColorAnim.keyTimes = [0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2]
        strokeColorAnim.duration = 2

        let transformAnim      = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values   = [NSValue(CATransform3D: CATransform3DIdentity),
                                      NSValue(CATransform3D: CATransform3DMakeScale(1.4, 1.4, 1)),
                                      NSValue(CATransform3D: CATransform3DMakeScale(0.8, 0.8, 1)),
                                      NSValue(CATransform3D: CATransform3DMakeScale(1.2, 1.2, 1)),
                                      NSValue(CATransform3D: CATransform3DIdentity)]
        transformAnim.keyTimes = [0, 0.5, 1, 1.5, 2]
        transformAnim.duration = 2

        let rainbowSparkingAnim : CAAnimationGroup = QCMethod.groupAnimations([strokeColorAnim, transformAnim], fillMode:fillMode)
        layers["self"]?.addAnimation(rainbowSparkingAnim, forKey:"rainbowSparkingAnim")
    }

    //MARK: - Animation Cleanup

    override func animationDidStop(anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValueForKey(anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.valueForKey("needEndAnim") as! Bool{
                updateLayerValuesForAnimationId(anim.valueForKey("animId") as? String)
                removeAnimationsForAnimationId(anim.valueForKey("animId") as? String)
            }
            completionBlock(flag)
        }
    }

    func updateLayerValuesForAnimationId(identifier: String? = "RainbowSparking"){
        if identifier == "RainbowSparking"{
            QCMethod.updateValueFromPresentationLayerForAnimation((layers["self"] as! CALayer).animationForKey("rainbowSparkingAnim"), theLayer:(layers["self"] as! CALayer))
        }
    }
    
    func removeAnimationsForAnimationId(identifier: String? = "RainbowSparking"){
        if identifier == "RainbowSparking"{
            (layers["self"] as! CALayer).removeAnimationForKey("rainbowSparkingAnim")
        }
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            (layer as! CALayer).removeAllAnimations()
        }
    }
}
