//
//  DrawView.swift
//  DrawSomethingSwift
//
//  Created by Apple on 15/01/19.
//  Copyright © 2019 Batth. All rights reserved.
//

import UIKit

class DrawView: UIView {

    fileprivate var lines = [Line]()
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth:CGFloat = 1
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for pointLine in lines{
            context.setStrokeColor(pointLine.strokeColor.cgColor)
            context.setLineWidth(pointLine.strokeWidth)
            for (index, point) in pointLine.lines.enumerated(){
                if index == 0{
                    context.move(to: point)
                }else{
                    context.addLine(to: point)
                }
            }
            context.strokePath()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let line = Line.init(strokeWidth: self.strokeWidth, strokeColor: self.strokeColor, lines: [CGPoint]())
        lines.append(line)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.lines.append(point)
        lines.append(lastLine)
        
        self.setNeedsDisplay()
    }
    
    
    func setStrokeWidth(_ width: CGFloat){
        self.strokeWidth = width
    }
    
    func setStrokeColor(_ color: UIColor){
        self.strokeColor = color
    }
    
    func undoAction(){
        lines.removeLast()
        self.setNeedsDisplay()
    }
    
    func clearAction(){
        lines.removeAll()
        self.setNeedsDisplay()
    }
}
