//
//  Networkable.swift
//  SME
//
//  Created by Aya Essam on 12/5/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<SubjectsApi> { get }
    
    func getSubjects(completion: @escaping ([Subjects], Error?) -> Void)
}
