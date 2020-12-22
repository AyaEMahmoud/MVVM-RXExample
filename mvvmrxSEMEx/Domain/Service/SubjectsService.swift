//
//  ProfilesService.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 12/3/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class SubjectsService {
    
    func getSubjects() -> Observable<[Subjects]> {
        return Observable.create { observer in
            let provider = MoyaProvider<SubjectsApi>()
            provider.rx.request(.getSubjects)
                .filterSuccessfulStatusCodes().map(Response.self)
                .subscribe(onSuccess: { (response) in
                    if let subjects = response.subjects {
                        observer.onNext(subjects)
                    }
                }, onError: { (error) in
                    observer.onError(error)
                })
            return Disposables.create()
        }
    }
}
