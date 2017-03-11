//
//  LoginViewController.swift
//  instagram
//
//  Created by Jason Wong on 3/8/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Error", message: "invalid username or password" , preferredStyle: .alert)
        
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error:Error?) in
            if user != nil{
                print("login success")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else
            {
                print("error:\(error?.localizedDescription)")
                let defaultAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
                alert.addAction(defaultAction)
                
                self.present(alert, animated: true, completion: nil)

            }
        }
    }
    
    
    @IBAction func signupButtonClicked(_ sender: Any) {
        
        let newUser = PFUser()
        
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        let alert = UIAlertController(title: "Error", message: "username taken!" , preferredStyle: .alert)
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success
            {
                print("worked")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else
            {
                print(error!.localizedDescription)
                let defaultAction = UIAlertAction(title: "Try again", style: .default, handler: nil)
                alert.addAction(defaultAction)
                
                self.present(alert, animated: true, completion: nil)

            }
        }
        
        
    }
    
  /*
     func alert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {action in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
