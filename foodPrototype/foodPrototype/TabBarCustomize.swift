//
//  TabBarCustomize.swift
//  foodPrototype
//
//  Created by 송 on 2018. 7. 30..
//  Copyright © 2018년 송. All rights reserved.
//

import Foundation

optional func tabBarController(_ tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
{
    let index = 3
    if index != 3 { return true }
    let modalViewController = MyModalViewController()
    currentViewController.presentViewController(modalViewController)
    return false
}


