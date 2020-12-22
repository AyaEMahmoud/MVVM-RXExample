//
//  ViewController.swift
//  mvvmrxSEMEx
//
//  Created by Aya Essam on 12/7/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit
import PullToRefreshKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var subjects = [Subjects]()
    var viewModel: SubjectsViewModel!
    var subjectsService = SubjectsService()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
        viewModel = SubjectsViewModel()
        bindViews(with: viewModel)
    }
    
    private func initPullToRefresh()-> Observable<Void> {
        return Observable.create { observer in
            self.collectionView.configRefreshHeader(container:self) {
            observer.onNext(())
        }
        return Disposables.create()
        }
    }
    
    private func initLoadMore()-> Observable<Void> {
        return Observable.create { observer in
            self.collectionView.configRefreshFooter(container:self) {
                self.collectionView.switchRefreshFooter(to: .refreshing)
                observer.onNext(())
            }
            return Disposables.create()
        }
    }
    
    private func initLoad()-> Observable<Void> {
        return Observable.create { observer in
                observer.onNext(())
            return Disposables.create()
          }
        }
    
    func registerCell() {
          collectionView.register(UINib(nibName: "SubjectCell", bundle: nil), forCellWithReuseIdentifier: "SubjectCell")
    }
    
    func bindViews(with viewModel: SubjectsViewModel) {
        viewModel.output.subjects.bind(to: collectionView.rx.items(cellIdentifier: "SubjectCell", cellType: SubjectCell.self)) {  row, subjects, cell in
                 cell.setCellData(subject: subjects)
            }
            .disposed(by: disposeBag)
        initLoad().subscribe(viewModel.input.load)
            .disposed(by: disposeBag)
        initLoadMore().subscribe(viewModel.input.loadMore)
            .disposed(by: disposeBag)
        initPullToRefresh().subscribe(viewModel.input.pullToRefresh)
            .disposed(by: disposeBag)
    }
    
}
