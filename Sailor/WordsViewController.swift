//
//  ViewController.swift
//  Sailor
//
//  Created by Eric on 9/19/14.
//  Copyright (c) 2014 erickreutz. All rights reserved.
//

import UIKit

class WordsViewController: UIViewController {
    private let firstWords: [String]!
    private let secondWords: [String]!
    private var firstWordsGenerator: IndexingGenerator<[String]>!
    private var secondWordsGenerator: IndexingGenerator<[String]>!
    
    override convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.firstWords = self.wordsFromFile("FirstWords")
        self.secondWords = self.wordsFromFile("SecondWords")
        self.firstWordsGenerator = self.firstWords.generate()
        self.secondWordsGenerator = self.secondWords.generate()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: UIViewController Overrides

extension WordsViewController {
    override func loadView() {
        let wordsView = WordsView(initialTopWord: self.nextFirstWord(), initialBottomWord: self.nextSecondWord())
        wordsView.model = self
        self.view = wordsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    private func wordsFromFile(filename: String) -> [String] {
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: "plist")
        let array = NSArray(contentsOfFile: path!)
        return array as [String]
    }
    
    private func nextFirstWord() -> String {
        if let word = self.firstWordsGenerator.next() {
            return word
        } else {
            self.firstWordsGenerator = self.firstWords.generate()
            return nextFirstWord()
        }
    }
    
    private func nextSecondWord() -> String {
        if let word = self.secondWordsGenerator.next() {
            return word
        } else {
            self.secondWordsGenerator = self.secondWords.generate()
            return nextSecondWord()
        }
    }
}

extension WordsViewController: WordsViewDataSource {
    func wordsView(wordsView: WordsView, wordForSection: WordsViewSection) -> String {
        switch(wordForSection) {
        case .Top:
            return self.nextFirstWord()
        case .Bottom:
            return self.nextSecondWord()
        }
    }
}

