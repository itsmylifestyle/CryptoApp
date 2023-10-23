//
//  ViewController.swift
//  CryproAppMVVMRxSwift
//
//  Created by Айбек on 19.10.2023.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, UITableViewDelegate /*UITableViewDataSource*/ {
    
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    let cryptoVM = CryptoViewModel()
    let disposeBag = DisposeBag()
    var cryptoList = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //tableView.delegate = self
        //tableView.dataSource = self
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        setupBindings()
        cryptoVM.requestData()
    }
    
    private func setupBindings() {
        
        cryptoVM.loading.bind(to: self.activityInd.rx.isAnimating).disposed(by: disposeBag)
        
        cryptoVM.error.observe(on: MainScheduler.asyncInstance).subscribe { errorStr in
            print(errorStr)
        }.disposed(by: disposeBag)
        
        /* cryptoVM.cryptos.observe(on: MainScheduler.asyncInstance).subscribe { cryptos in
         self.cryptoList = cryptos
         self.tableView.reloadData()
         }.disposed(by: disposeBag) */
        
        //        cryptoVM.cryptos.observe(on: MainScheduler.asyncInstance).bind(to: tableView.rx.items(cellIdentifier: <#T##String#>))
        
        cryptoVM.cryptos.observe(on: MainScheduler.asyncInstance).bind(to: tableView.rx.items(cellIdentifier: "cryCell", cellType: cryptoCell.self)) {row, item, cell in
            cell.item = item
        }.disposed(by: disposeBag)
    }
    
    /*
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return cryptoList.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = UITableViewCell()
     var content = cell.defaultContentConfiguration()
     content.text = cryptoList[indexPath.row].currency
     content.secondaryText = cryptoList[indexPath.row].price
     cell.contentConfiguration = content
     return cell
     }*/
    
}

