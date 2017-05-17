//
//  Scene1Configurator.swift
//  GameTracker
//
//  Created by Andrew Jennings on 17/05/2017.
//  Copyright © 2017 aj. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension Scene1ViewController: Scene1PresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    router.passDataToNextScene(segue: segue)
  }
}

extension Scene1Interactor: Scene1ViewControllerOutput
{
}

extension Scene1Presenter: Scene1InteractorOutput
{
}

class Scene1Configurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = Scene1Configurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: Scene1ViewController)
  {
    let router = Scene1Router()
    router.viewController = viewController
    
    let presenter = Scene1Presenter()
    presenter.output = viewController
    
    let interactor = Scene1Interactor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
