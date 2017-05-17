//
//  Presenter.swift
//  GameTracker
//
//  Created by Andrew Jennings on 17/05/2017.
//  Copyright © 2017 aj. All rights reserved.
//

import UIKit

protocol Scene1PresenterInput
{
  func presentSomething(response: Scene1ViewModal.Something.Response)
}

protocol Scene1PresenterOutput: class
{
  func displaySomething(viewModel: Scene1ViewModal.Something.ViewModel)
}

class Scene1Presenter: Scene1PresenterInput
{
  weak var output: Scene1PresenterOutput!
  
  // MARK: - Presentation logic
  
  func presentSomething(response: Scene1ViewModal.Something.Response)
  {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller
    
    let viewModel = Scene1ViewModal.Something.ViewModel()
    output.displaySomething(viewModel: viewModel)
  }
}

