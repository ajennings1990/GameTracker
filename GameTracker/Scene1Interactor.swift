//
//  Scene1Interactor.swift
//  GameTracker
//
//  Created by Andrew Jennings on 17/05/2017.
//  Copyright © 2017 aj. All rights reserved.
//

import UIKit

protocol Scene1InteractorInput
{
  func doSomething(request: Scene1ViewModal.Something.Request)
}

protocol Scene1InteractorOutput
{
  func presentSomething(response: Scene1ViewModal.Something.Response)
}

class Scene1Interactor: Scene1InteractorInput
{
  var output: Scene1InteractorOutput!
  var worker: Scene1Worker!
  
  // MARK: - Business logic
  
  func doSomething(request: Scene1ViewModal.Something.Request)
  {
    // NOTE: Create some Worker to do the work
    
    worker = Scene1Worker()
    worker.doSomeWork()
    
    // NOTE: Pass the result to the Presenter
    
    let response = Scene1ViewModal.Something.Response()
    output.presentSomething(response: response)
  }
}

