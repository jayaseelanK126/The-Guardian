//
//  AppDelegate.swift
//  The Guardian
//
//  Created by Pyramid on 24/10/21.
//

import UIKit
import RealmSwift
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        realmMigration()
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.guardianapis.content", using: nil) { task in
        //This task is cast with processing request (BGAppRefreshTask)
        self.handleAppRefreshTask(task: task as! BGAppRefreshTask)
        }
        
        return true
    }
    
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
        print("Handling task")
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        var newsListModelViewObj = NewsListModelView()
        newsListModelViewObj.backGroundRefreshMethod {
            
            NotificationCenter.default.post(name: .didReceiveData, object: nil)
            
            task.setTaskCompleted(success: true)
        }
        
        scheduleAppRefresh()
    }
    
    func scheduleAppRefresh() {
    let request = BGAppRefreshTaskRequest(identifier: "com.guardianapis.content")
    request.earliestBeginDate = Date(timeIntervalSinceNow: 2 * 60) // App Refresh after 2 minute.
    //Note :: EarliestBeginDate should not be set to too far into the future.
    do {
    try BGTaskScheduler.shared.submit(request)
    } catch {
    print("Could not schedule app refresh: (error)")
    }
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


    func realmMigration()
    {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 100,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1)
                {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        Realm.Configuration.defaultConfiguration = config
        print(config.fileURL!)
    }
}



