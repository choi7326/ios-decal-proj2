//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var HangmanImage: UIImageView!
    @IBOutlet weak var Guesses: UILabel!
    @IBOutlet weak var KnownString: UILabel!
    
    var pickerData: [String] = [String]()
    var pickedItem: String = "A"
    
    var numberOfIncorrectGuesses = 0
    var gameOver = false
    var initialKnownString = ""
    var hangman: Hangman = Hangman()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        hangman.start()
        initialKnownString = hangman.knownString!
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        pickerData = ["A", "B", "C", "D", "E", "F", "G", "H",
            "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",
            "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        updateViewAndCheckIfGameOver()
    }
    
    @IBAction func TappedNewGameButton(sender: AnyObject) {
        numberOfIncorrectGuesses = 0
        gameOver = false
        hangman.start()
        initialKnownString = hangman.knownString!
        updateViewAndCheckIfGameOver()
    }
    
    @IBAction func TappedGuessButton(sender: AnyObject) {
        print(pickedItem)
        if (gameOver || hangman.guessedLetters?.containsObject(pickedItem) == true){
            
        } else if (hangman.guessLetter(pickedItem) == false) {
            numberOfIncorrectGuesses += 1
        }
        updateViewAndCheckIfGameOver()
    }

    @IBAction func TappedStartOverButton(sender: AnyObject) {
        numberOfIncorrectGuesses = 0
        gameOver = false
        hangman.knownString = initialKnownString
        hangman.guessedLetters = NSMutableArray()
        updateViewAndCheckIfGameOver()
    }
    
    func updateViewAndCheckIfGameOver() {
        switch (numberOfIncorrectGuesses){
            case 0:
                HangmanImage.image = UIImage(named: "hangman1.gif")
            break
            case 1:
                HangmanImage.image = UIImage(named: "hangman2.gif")
            break
            case 2:
                HangmanImage.image = UIImage(named: "hangman3.gif")
            break
            case 3:
                HangmanImage.image = UIImage(named: "hangman4.gif")
            break
            case 4:
                HangmanImage.image = UIImage(named: "hangman5.gif")
            break
            case 5:
                HangmanImage.image = UIImage(named: "hangman6.gif")
            break
            default:
                HangmanImage.image = UIImage(named: "hangman7.gif")
                gameOver = true
                showLoseAlertMessage()
            break
        }
        self.Guesses.text = "Guesses: " + hangman.guesses()
        self.KnownString.text = hangman.knownString
        if (numberOfIncorrectGuesses < 6 && hangman.answer == hangman.knownString) {
            gameOver = true
            showWinAlertMessage()
        }
    }
    
    func showWinAlertMessage() {
        let alertController = UIAlertController(title: "Game Over", message: "You Win!", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }
    func showLoseAlertMessage() {
        let alertController = UIAlertController(title: "Game Over", message: "You Lose!", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        print("called pickerview")
        pickedItem = pickerData[row]
    }
}

