//
//  ViewController
//  GameTracker
//
//  Created by Andrew Jennings on 17/05/2017.
//  Copyright © 2017 aj. All rights reserved.
//

import UIKit

protocol Scene1ViewControllerInput
{
  func displaySomething(viewModel: Scene1ViewModal.Something.ViewModel)
}

protocol Scene1ViewControllerOutput
{
  func doSomething(request: Scene1ViewModal.Something.Request)
}

class Scene1ViewController: UIViewController, Scene1ViewControllerInput
{
  var output: Scene1Interactor!
  var router: Scene1Router!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    Scene1Configurator.sharedInstance.configure(viewController: self)
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomethingOnLoad()
  }
  
  // MARK: - Event handling
  
  func doSomethingOnLoad()
  {
    // NOTE: Ask the Interactor to do some work
    
    let request = Scene1ViewModal.Something.Request()
    output.doSomething(request: request)
  }
  
  // MARK: - Display logic
  
  func displaySomething(viewModel: Scene1ViewModal.Something.ViewModel)
  {
    // NOTE: Display the result from the Presenter
    
    // nameTextField.text = viewModel.name
  }
}

