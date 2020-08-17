//
//  AppDelegate.swift
//  link-manager
//
//  Created by Productivity on 8/16/20.
//

import UIKit
import Firebase

var uid : String = ""
var folders : [Folder] = []

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            guard let user = authResult?.user else { return }
            _ = user.isAnonymous  // true
            uid = user.uid
            print(uid)
            
            Firestore.firestore().collection("users").document(uid).getDocument { (doc,error) in
                if let err = error {
                    print(err)
                } else {
                    let directFolderData = doc?.get("folders") as? [String : [String]] ?? [:]
                    if directFolderData == [:] {
                        Firestore.firestore().collection("users").document(uid).setData([
                            "folders" : [:]
                        ],merge:true)
                    }
                    
                    for (fName,folderLinks) in directFolderData {
                        
                        var folderClassLinks : [Link] = []
                        
                        for linkTotal in folderLinks {
                            let component_link = linkTotal.components(separatedBy: ",")
                            let link = Link(name: component_link[0], link: component_link[1])
                            
                            folderClassLinks.append(link)
                        }
                        folders.append(Folder(name: fName, links: folderClassLinks))
                    }
                    
                }
                
            }
            
            
            
            Firestore.firestore().collection("users").document(uid).setData([
                "uid" : uid
            ],merge:true)
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

