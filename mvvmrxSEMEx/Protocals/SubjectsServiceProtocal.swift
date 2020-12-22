//
//  SubjectsServiceProtocal.swift
//  mvvmrxSEMEx
//
//  Created by Aya Essam on 12/21/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import RxSwift

protocol SubjectsServiceProtocol {
    func getSubjects()-> Observable<[Subjects]>
}
