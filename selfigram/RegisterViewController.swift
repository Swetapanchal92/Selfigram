//
//  RegisterViewController.swift
//  selfigram
//
//  Created by Nitin Panchal on 2017-09-21.
//  Copyright © 2017 Sweta panchal. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPwdTextField: UITextField!
    @IBOutlet weak var reenterPwdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func RegisterButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPwdTextField.text
        let reEnterPassword = reenterPwdTextField.text
        
        if(userEmail!.isEmpty || userPassword!.isEmpty || reEnterPassword!.isEmpty){
            displayMyAlertMessage(title: "Alert", userMsg: "All fields are required.....!!!")
            return;
        }
            else{
            let newUser = PFUser()
            let username = userEmail
            let password = userPassword
            newUser.username = username
            newUser.password = password
        
            newUser.signUpInBackground(block: { (succeed, error) -> Void in
                
                // Stop the spinner
               
                if ((error) != nil) {
                     self.displayMyAlertMessage(title: "Alert", userMsg: "User Already Exist")
                    return
                }
                //else {
                
                    DispatchQueue.main.async(execute: { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                        self.present(viewController, animated: true, completion: nil)
                    })
                    
                //}
            })
                
            }
        
        
        if(userPassword != reEnterPassword){
            displayMyAlertMessage(title:"Alert",userMsg: "Passwords do not match")
            return;
        }
        
        
        
        
       
        
    }
    
    func displayMyAlertMessage(title: String ,userMsg: String)
    {
        let MyAlert = UIAlertController(title:title, message:userMsg, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        MyAlert.addAction(okAction)
        self.present(MyAlert, animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
