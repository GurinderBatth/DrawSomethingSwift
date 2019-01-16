//
//  ViewController.swift
//  DrawSomethingSwift
//
//  Created by Apple on 14/01/19.
//  Copyright © 2019 Batth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let drawView = DrawView()
    
    var undoButton: UIButton = {
        let btnUndo = UIButton(type: .custom)
        btnUndo.setTitle("Undo", for: .normal)
        btnUndo.setTitleColor(.black, for: .normal)
        return btnUndo
    }()
    
    
    var clearButton: UIButton = {
        let btnClear = UIButton(type: .custom)
        btnClear.setTitle("Clear", for: .normal)
        btnClear.setTitleColor(.black, for: .normal)
        return btnClear
    }()
    
    var btnYellow: UIButton = {
        let btnY = UIButton(type: .custom)
        btnY.backgroundColor = .yellow
        return btnY
    }()
    
    
    var btnRed: UIButton = {
        let btnR = UIButton(type: .custom)
        btnR.backgroundColor = .red
        return btnR
    }()
   
    var btnBlue: UIButton = {
        let btnB = UIButton(type: .custom)
        btnB.backgroundColor = .blue
        return btnB
    }()
    
    var slider: UISlider = {
        let sli = UISlider()
        sli.minimumValue = 1
        sli.maximumValue = 10
        return sli
    }()
    
    override func loadView() {
        super.loadView()
        drawView.frame = self.view.frame
        drawView.backgroundColor = .white
        self.view.addSubview(drawView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews(){
        undoButton.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        btnYellow.addTarget(self, action: #selector(yellowColor), for: .touchUpInside)
        btnRed.addTarget(self, action: #selector(redColor), for: .touchUpInside)
        btnBlue.addTarget(self, action: #selector(blueColor), for: .touchUpInside)
        slider.addTarget(self, action: #selector(strokeWidth(_:)), for: .valueChanged)
        
        let stackViewColors = UIStackView(arrangedSubviews: [btnYellow,btnRed,btnBlue])
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton,stackViewColors,slider])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        
        drawView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: self.drawView.leadingAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.drawView.layoutMarginsGuide.bottomAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.drawView.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func handleUndo(){
        drawView.undoAction()
    }
    
    @objc func handleClear(){
        drawView.clearAction()
    }
    
    @objc func yellowColor(){
        drawView.setStrokeColor(.yellow)
    }
    
    @objc func redColor(){
        drawView.setStrokeColor(.red)
    }
    
    @objc func blueColor(){
        drawView.setStrokeColor(.blue)
    }

    
    @objc func strokeWidth(_ slider: UISlider){
        drawView.setStrokeWidth(CGFloat(slider.value))
    }
}

