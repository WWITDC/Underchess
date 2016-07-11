//
//  UCPieceView.swift
//  Underchess
//
//  Created by Apollonian on 3/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

enum UCUserInputError:ErrorProtocol{
    case controlUnownedPiece
    case noValidMove
    case needUserSelection
}

protocol UCPieceViewDelegate{
    func get(error: UCUserInputError)
    func touchUpInside(pieceWithIndex: Int) throws
}

@IBDesignable class UCPieceView: UIView {
    
    var currentTouchMovingDirection: UCDirection?
    var delegate: UCPieceViewDelegate?
    
    init(color: UIColor){
        super.init(frame: CGRect.zero)
        backgroundColor = color
        alpha = 0
        layer.borderWidth = 5
        layer.borderColor = UIColor.white().cgColor
    }

    init(color: UIColor, strokeColor: UIColor, strokeWdith: CGFloat){
        super.init(frame: CGRect.zero)
        backgroundColor = color
        alpha = 0
        layer.borderWidth = strokeWdith
        layer.borderColor = strokeColor.cgColor
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
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("UC doesn't support NSCoder")
    }

    func round(){
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }

//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesMoved(touches, withEvent: event)
//        
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if currentTouchMovingDirection == nil{
            if let handler = delegate{
                do{
                    try handler.touchUpInside(pieceWithIndex: tag)
                } catch let error where error is UCUserInputError {
                    handler.get(error: error as! UCUserInputError)
                } catch {
                    return
                }
            }
        }
    }

    // MARK: Quartz Code exported animation
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var updateLayerValueForCompletedAnimation : Bool = false

    //func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
        //CATransaction.begin()
        //CATransaction.setDisableActions(true)
        //CATransaction.commit()
    //}

    //MARK: - Animation Setup

    func addRainbowSparkingAnimation(){
        addRainbowSparkingAnimationCompletionBlock(nil)
    }

    func addRainbowSparkingAnimationCompletionBlock(_ completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 2
            completionAnim.delegate = self
            completionAnim.setValue("RainbowSparking", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.add(completionAnim, forKey:"RainbowSparking")
            if let anim = layer.animation(forKey: "RainbowSparking"){
                completionBlocks[anim] = completionBlock
            }
        }

        let fillMode = kCAFillModeForwards

        ////Animation
        let strokeColorAnim      = CAKeyframeAnimation(keyPath:"borderColor")
        strokeColorAnim.values   = [UIColor.white().cgColor,
                                        UIColor.red().cgColor,
                                        UIColor.orange().cgColor,
                                        UIColor.yellow().cgColor,
                                        UIColor.green().cgColor,
                                        UIColor.cyan().cgColor,
                                        UIColor.blue().cgColor,
                                        UIColor.purple().cgColor,
                                        UIColor.white().cgColor]
        strokeColorAnim.keyTimes = [0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2]
        strokeColorAnim.duration = 2

        let transformAnim      = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values   = [NSValue(caTransform3D: CATransform3DIdentity),
                                      NSValue(caTransform3D: CATransform3DMakeScale(1.4, 1.4, 1)),
                                      NSValue(caTransform3D: CATransform3DMakeScale(0.8, 0.8, 1)),
                                      NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1)),
                                      NSValue(caTransform3D: CATransform3DIdentity)]
        transformAnim.keyTimes = [0, 0.5, 1, 1.5, 2]
        transformAnim.duration = 2

        let rainbowSparkingAnim : CAAnimationGroup = QCMethod.groupAnimations([strokeColorAnim, transformAnim], fillMode:fillMode)
        rainbowSparkingAnim.isRemovedOnCompletion = false
        rainbowSparkingAnim.autoreverses = true
        layer.add(rainbowSparkingAnim, forKey:"rainbowSparkingAnim")
    }

    //MARK: - Animation Cleanup

    override func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValue(forKey: anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
                updateLayerValuesForAnimationId(anim.value(forKey: "animId") as? String)
                removeAnimationsForAnimationId(anim.value(forKey: "animId") as? String)
            }
            completionBlock(flag)
        }
    }

    func updateLayerValuesForAnimationId(_ identifier: String? = "RainbowSparking"){
        if identifier == "RainbowSparking"{
            QCMethod.updateValueFromPresentationLayerForAnimation(layer.animation(forKey: "rainbowSparkingAnim"), theLayer:(layer))
        }
    }
    
    func removeAnimationsForAnimationId(_ identifier: String? = "RainbowSparking"){
        if identifier == "RainbowSparking"{
            layer.removeAnimation(forKey: "rainbowSparkingAnim")
        }
    }
    
    func removeAllAnimations(){
        layer.removeAllAnimations()
    }
}
