//
//  ViewControllerDelegate.swift
//  mvvmrxSEMEx
//
//  Created by Aya Essam on 12/20/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation

protocol ViewControllerDelegate: AnyObject {
    func getSubjects(subjects: [Subjects])
}
