//
//  WordsView.swift
//  Sailor
//
//  Created by Eric on 9/19/14.
//  Copyright (c) 2014 erickreutz. All rights reserved.
//

import UIKit

enum WordsViewSection {
    case Top
    case Bottom
}

protocol WordsViewDataSource {
    func wordsView(wordsView: WordsView, wordForSection: WordsViewSection) -> String
}

class WordsView: UIView {
    var model: WordsViewDataSource?
    
    private let topWordView: WordView = WordView(frame: CGRectZero)
    private let bottomWordView: WordView = WordView(frame: CGRectZero)
    
    private lazy var topWordViewTapGestureRecognizer: UITapGestureRecognizer = {
       return  UITapGestureRecognizer(target: self, action: Selector("topWordViewTapped:"))
    }()
    
    private lazy var bottomWordViewTapGestureRecognizer: UITapGestureRecognizer = {
        return  UITapGestureRecognizer(target: self, action: Selector("bottomWordViewTapped:"))
    }()
    
    convenience init(initialTopWord: String, initialBottomWord: String) {
        self.init(frame: CGRectZero)
        
        self.topWordView.label.text = initialTopWord
        self.bottomWordView.label.text = initialBottomWord
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topWordView.backgroundColor = UIColor.redColor()
        bottomWordView.backgroundColor = UIColor.greenColor()
        
        self.addSubview(topWordView)
        self.addSubview(bottomWordView)
        
        self.topWordView.addGestureRecognizer(self.topWordViewTapGestureRecognizer)
        self.bottomWordView.addGestureRecognizer(self.bottomWordViewTapGestureRecognizer)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.addConstraints([
            topWordView.al_height     == self.al_height * 0.5 - 15,
            topWordView.al_width      == self.al_width - 20,
            topWordView.al_centerX    == self.al_centerX,
            topWordView.al_top        == self.al_top + 10,
            bottomWordView.al_width   == self.al_width - 20,
            bottomWordView.al_centerX == self.al_centerX,
            bottomWordView.al_height  == self.al_height * 0.5 - 15,
            bottomWordView.al_bottom  == self.al_bottom - 10
        ])
    }
    
    func topWordViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        switch(gestureRecognizer.state) {
        case .Ended:
            self.handleWordViewTapForSection(.Top)
            break
        default:
            break
        }
    }
    
    func bottomWordViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        switch(gestureRecognizer.state) {
        case .Ended:
            self.handleWordViewTapForSection(.Bottom)
            break
        default:
            break
        }

    }
    
    func handleWordViewTapForSection(section: WordsViewSection) {
        var word = self.model?.wordsView(self, wordForSection: section)
        var view = self.viewForSection(section)
        
        UIView.beginAnimations("flip", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: view, cache: true)
        
        if let foundWord = word {
            view.label.text = foundWord
        }
        
        UIView.commitAnimations()
    }
    
    func viewForSection(section: WordsViewSection) -> WordView {
        switch(section) {
        case .Top:
            return self.topWordView
        case .Bottom:
            return self.bottomWordView
        }
    }

}