//
//  SubjectsViewModel.swift
//  mvvmrxSEMEx
//
//  Created by Aya Essam on 12/20/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SubjectsViewModel: ViewModelProtocol {
    
    struct Input {
        let load: AnyObserver<Void>
        let loadMore: AnyObserver<Void>
        let pullToRefresh: AnyObserver<Void>
    }
    
    struct Output {
        let rx_isLoading: Observable<Bool>
        let windlessStart:Observable<Bool>
        var subjects : Observable<[Subjects]>
        let serverErrorsObservable: Observable<String>
    }
    
    var input: Input
    let output: Output
    
    private let rx_isLoadingSubject = PublishSubject<Bool>()
    private let windlessStartSubject = PublishSubject<Bool>()
    private var page = 1
    private let loadSubject = PublishSubject<Void>()
    private let loadMoreSubject = PublishSubject<Void>()
    private let pullToRefreshSubject = PublishSubject<Void>()
    private let subjects =  BehaviorRelay<[Subjects]>(value: [])
    private let serverErrorsSubject = PublishSubject<String>()
    private let disposeBag = DisposeBag()
    private var subjectService = SubjectsService()

    init() {
        input = Input(load: loadSubject.asObserver(), loadMore: loadMoreSubject.asObserver(),
                      pullToRefresh: pullToRefreshSubject.asObserver())
    
        output = Output(rx_isLoading: rx_isLoadingSubject.asObservable(), windlessStart: windlessStartSubject.asObserver(), subjects: subjects.asObservable(),serverErrorsObservable: serverErrorsSubject.asObservable())
        
        observeLoading()
    }
    
    private func observeLoading() {
        loadSubject.subscribe(onNext:{  _ in
            self.getSubjects()
        }).disposed(by: disposeBag)
        loadMoreSubject.subscribe(onNext:{  _ in
            self.page += 1
            self.getSubjects()
        }).disposed(by: disposeBag)
        pullToRefreshSubject.subscribe(onNext:{  _ in
            self.page = 1
            self.getSubjects()
        }).disposed(by: disposeBag)
    }
    
    private func hideLoading () {
        self.rx_isLoadingSubject.onNext(false)
        self.windlessStartSubject.onNext(false)
    }
    
    private func getSubjects() {
        self.subjectService.getSubjects().materialize().subscribe(onNext: { [weak self] event in
            self?.hideLoading()
            switch event {
            case .next(let subjects):
                self?.set(returnedSubjects: subjects)
            case .error(let error):
                if self?.page == 1 {
                self?.getSubjects()
                }
                self?.serverErrorsSubject.onNext(error.localizedDescription)
            default:
                break
            }
        })
            .disposed(by: disposeBag)
    }
    
    private func set(returnedSubjects: [Subjects]) {
        var subjects = [Subjects]()
        if self.page != 1 {
            subjects.append(contentsOf: self.subjects.value)
        }
        subjects.append(contentsOf: returnedSubjects)
        self.subjects.accept(returnedSubjects)
    }
}
