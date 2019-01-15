//
//  DrawView.swift
//  DrawSomethingSwift
//
//  Created by Apple on 15/01/19.
//  Copyright © 2019 Batth. All rights reserved.
//

import UIKit

class DrawView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for pointLine in lines{
            for (index, point) in pointLine.enumerated(){
                if index == 0{
                    context.move(to: point)
                }else{
                    context.addLine(to: point)
                }
            }
        }
        context.strokePath()
    }
    
    fileprivate var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.append(point)
        lines.append(lastLine)
        
        self.setNeedsDisplay()
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
