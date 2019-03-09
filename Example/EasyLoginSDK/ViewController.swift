//
//  ViewController.swift
//  EasyLoginSDK
//
//  Created by Appsim on 03/06/2019.
//  Copyright (c) 2019 Appsim. All rights reserved.
//

import UIKit
import EasyLoginSDK

class ViewController: UIViewController {
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var btnActive: UIButton!
    
    var auth: AuthResult?
    
    @IBAction func activeClick(_ sender: Any) {
        if let `auth` = self.auth {
            activeProfile(auth: auth)
        }
    }
    @IBAction func loginClick(_ sender: Any) {
        do {
            try EasyLoginFactory.shared.authorize(provider: "line") { (result) in
                switch result {
                case .success(let auth):
                    self.auth = auth
                    self.getProfile(auth: auth)
                    break
                case .failure(let error):
                    self.showError(error: error)
                    break
                }
            }
        } catch {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    
    func showError(error: Error) {
        print(error.localizedDescription)
    }
    
    func verifyToken(auth: AuthResult) {
        
    }
    
    func getProfile(auth: AuthResult) {
        auth.getAuthorizedProfile { (result) in
            switch result {
            case .success(let profile):
                print("UserID = \(profile.userId ?? "Not found")")
                DispatchQueue.main.async {
                    self.lbUserName.text = profile.attrs["displayName"] ?? ("UserID = \(profile.userId ?? "Not found")")
                    self.lbUserName.isHidden = false
                    self.btnActive.isHidden = false
                }
                break
            case .failure(let error):
                self.showError(error: error)
                break
            }
        }
    }
    
    func activeProfile(auth: AuthResult) {
        auth.activateAuthorizedProfile(completionHandler: { (resultActive) in
            switch resultActive {
            case .success(let isSuccess):
                break
            case .failure(let activeError):
                self.showError(error: activeError)
                break
            }
        })
    }
}

