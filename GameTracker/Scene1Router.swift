//
//  Scene1Router.swift
//  GameTracker
//
//  Created by Andrew Jennings on 17/05/2017.
//  Copyright © 2017 aj. All rights reserved.
//

import UIKit

protocol Scene1RouterInput
{
  func navigateToSomewhere()
}

class Scene1Router: Scene1RouterInput
{
  weak var viewController: Scene1ViewController!
  
  // MARK: - Navigation
  
  func navigateToSomewhere()
  {
    // NOTE: Teach the router how to navigate to another scene. Some examples follow:
    
    // 1. Trigger a storyboard segue
    // viewController.performSegueWithIdentifier("ShowSomewhereScene", sender: nil)
    
    // 2. Present another view controller programmatically
    // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)
    
    // 3. Ask the navigation controller to push another view controller onto the stack
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
    
    // 4. Present a view controller from a different storyboard
    // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
    // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
    // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
  }
  
  // MARK: - Communication
  
  func passDataToNextScene(segue: UIStoryboardSegue)
  {
    // NOTE: Teach the router which scenes it can communicate with
    
    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue)
    }
  }
  
  func passDataToSomewhereScene(segue: UIStoryboardSegue)
  {
    // NOTE: Teach the router how to pass data to the next scene
    
    // let someWhereViewController = segue.destinationViewController as! SomeWhereViewController
    // someWhereViewController.output.name = viewController.output.name
  }
}
