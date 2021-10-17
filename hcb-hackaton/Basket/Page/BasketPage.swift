//
//  BasketPage.swift
//  hcb-hackaton
//
//  Created by Nurzhigit on 17.10.2021.
//

import UIKit

final class BasketPage: UIViewController {
    
    lazy  var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(BasketItemCell.self, forCellReuseIdentifier: "BasketItemCell")
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    let bottomPriceView: BasketPriceView = {
        let view = BasketPriceView()
        view.addButton.addTarget(self, action: #selector(addTouched), for: .touchUpInside)
        return view
    }()
    
    @objc func addTouched() {
        self.navigationController?.popViewController(animated: true)
    }
    
    let monthView: TrippleMonthView = {
        let view = TrippleMonthView()
        view.month6view.state = .selected
        return view
    }()
    let loanView: BasketClickableView = {
        let view = BasketClickableView()
        view.textLabel.text = "Рассрочка на"
        return view
    }()
    let creditView: BasketClickableView = {
        let view = BasketClickableView()
        view.state = .disabled
        return view
    }()
    
    let items = [BasketItemCellModel(image: #imageLiteral(resourceName: "iphone"), title: "iPhone 12 mini, 256 gb",
                                     subTitle: "Смартфоны", price: "399 999,00 ₸"),
                 BasketItemCellModel(image: #imageLiteral(resourceName: "mackbook"), title: "Macbook Pro 13 2020 M1",
                                                  subTitle: "Ноутбуки", price: "573 520,00 ₸")]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}
private extension BasketPage {
    func setup() {
        title = "Покупка товара"
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = Colors.mainBlack
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        view.addSubview(tableView)
        view.addSubview(bottomPriceView)
        view.addSubview(loanView)
        view.addSubview(creditView)
        
        view.addSubview(monthView)
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(loanView.snp.top)
        }
        
        creditView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(loanView.snp.top)
        }
    
        loanView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalTo(bottomPriceView.snp.top)
        }
        
        monthView.snp.makeConstraints { make in
            make.left.equalTo(loanView.snp.right)
            make.right.equalToSuperview()
            make.top.equalTo(loanView.snp.top)
        }
        
        bottomPriceView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension BasketPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketItemCell", for: indexPath) as! BasketItemCell
        cell.configure(model: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
        label.text = "Корзина"
        label.font = .medium20
        label.textColor = .black
        headerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(12)
        }
        return headerView
    }

}
