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
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        
        drawView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: self.drawView.leadingAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.drawView.layoutMarginsGuide.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func handleUndo(){
        drawView.undoAction()
    }
    
    @objc func handleClear(){
        drawView.clearAction()
    }
    
}

