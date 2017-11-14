//
//  LoginViewController.swift
//  selfigram
//
//  Created by Nitin Panchal on 2017-09-26.
//  Copyright © 2017 Sweta panchal. All rights reserved.
//

import UIKit
import Parse
import FBSDKLoginKit
//import FBSDKCoreKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate{

    @IBOutlet weak var EmailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.frame = CGRect(x: 80, y: 450, width: 100, height: 28)
        view.addSubview(loginButton)
        loginButton.readPermissions = ["email","public_profile"]
        loginButton.delegate = self

//        if (FBSDKAccessToken.current() != nil)
//        {
//            view.willRemoveSubview(loginButton)
//            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController")
//            self.present(viewController, animated: true, completion: nil)
//        }
        
    }
        
        func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!){
            if error != nil {
                print(error)
                return;
            }
                
            else {
                print("Successfuly logged using Facebook");
               // showEmailAddress()
                if (FBSDKAccessToken.current() != nil)
                {
                    //view.willRemoveSubview(loginButton)
                    self.nextViewController()
                }
                
            }
 
        }
        
        func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
           print("Did log out of Facebook")
        }
    
    
        
//        func showEmailAddress() {
//            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, err) in
//                
//                if err != nil {
//                    print("Failed to start graph request \(String(describing: err))")
//                    return;
//                }
//                print(result!)
//                
//            })
//        }

        

        
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let uname = EmailIdTextField.text
        let pwd = passwordTextField.text
        
        if(uname!.isEmpty || pwd!.isEmpty){
            displayMyAlertMessage(title: "Alert", userMsg: "All fields are required...!!!!")
            return;
        }
        else
        {
            PFUser.logInWithUsername(inBackground: uname!, password: pwd!, block: { (user,      error) -> Void in
                if ((user) != nil) {
                    self.nextViewController()
                }
                else {
                    self.displayMyAlertMessage(title: "Error", userMsg: "Username and Password is wrong.... Please enter correct Username & Password...!!!")
                }
            })
        }
        
        

    }
    
    func nextViewController() {
        DispatchQueue.main.async(execute: { () -> Void in
            let viewController:UITabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "selfigramTabBar") as! UITabBarController
            self.present(viewController, animated: true, completion: nil)
        })
        
    }
    
    func displayMyAlertMessage(title: String, userMsg: String)
    {
        let MyAlert = UIAlertController(title: title, message:userMsg, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        
        MyAlert.addAction(okAction)
        self.present(MyAlert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
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
