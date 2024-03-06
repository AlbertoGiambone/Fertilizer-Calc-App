//
//  ViewController.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 14/01/22.
//

import UIKit
import CoreData
import Firebase
import AVFoundation
import Network
import RevenueCat
import StoreKit
import DGCharts

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var refreshControl = UIRefreshControl()
    
    //MARK: Connection

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var pullToRefreshLabel: UILabel!
    
    @IBOutlet weak var VCTitle: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    
    
    
    //MARK: functinality
    
    let db = Firestore.firestore()
    
    //Array
    
    var whole = [FarmField]()
    var single: FarmField?
    var fertilization = [Fertilization]()
    
    @IBAction func PlusButtontapped(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "New Field", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Area Ha"
            textField.keyboardType = .decimalPad
        }
        
        
        let action = UIAlertAction(title: "Save", style: .default)  { (_) in
            let Name = alert.textFields![0].text
            var Area = alert.textFields![1].text
            
            if Name == "" {
                print("NO NAME!")
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                self.present(alert, animated: true, completion: nil)
            }

            let db = Firestore.firestore()
            
            Area?.replace(",", with: ".")
            db.collection("FarmField").addDocument(data: [
                "name": String(Name ?? ""), "area": String(Area ?? ""), "nitrogenLimit": "", "phosphorusLimit": "", "potassiumLimit": "", "calciumLimit": "", "magnesiumLimit": "", "UID": self.userID!, "DID": ""
            
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                }
            }
            
            self.whole.removeAll()
            Task {
                await self.queryFirestoreField()
                
            }
            
            self.run(after: 1){
            self.table.reloadData()
                }
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
        
    
        
        
    }
    
    //MARK: Firestore CALL
    
    
    func queryFirestoreField() async {
        
        let db = Firestore.firestore()
        
        do {
            let querySnapshot = try await db.collection("FarmField").whereField("UID", isEqualTo: userID ?? "").getDocuments()
            for document in querySnapshot.documents {
                let y = FarmField(name: document.data()["name"] as? String ?? "", area: document.data()["area"] as? String ?? "", growing: document.data()["growing"] as? String ?? "", nitrogenLimit: document.data()["nitrogenLimit"] as? String ?? "", phosphorusLimit: document.data()["phosphorusLimit"] as? String ?? "", potassiumLimit: document.data()["potassiumLimit"] as? String ?? "", calciumLimit: document.data()["calciumLimit"] as? String ?? "", magnesiumLimit: document.data()["magnesiumLimit"] as? String ?? "", UID: self.userID ?? "", DID: document.documentID)
                
                self.whole.append(y)
                //print("QUESTO é IL CAMPO: \(y)")
            }
        } catch let err {
            print("Error getting documents: \(err)")
        }
        self.table.reloadData()
    }

    func queryFertilization() async {
        
        let db = Firestore.firestore()
        
        do{
            let querySnapShot = try await db.collection("Ferilization").whereField("UID", isEqualTo: userID ?? "").getDocuments()
            for doc in querySnapShot.documents {
                let f = Fertilization(nitrogen: doc.data()["nitrogen"] as? String ?? "", phosphorus: doc.data()["phosphorus"] as? String ?? "", potassium: doc.data()["potassium"] as? String ?? "", calcium: doc.data()["calcium"] as? String ?? "", magnesium: doc.data()["magnesium"] as? String ?? "", quantity: doc.data()["quantity"] as? String ?? "", date: doc.data()["date"] as? String ?? "", UID: doc.data()["UID"] as? String ?? "", FID: doc.data()["FID"] as? String ?? "", DID: doc.documentID)
                self.fertilization.append(f)
            }
        } catch let err {
            print("Error Getting Fertilizaion doc: \(err)")
        }
        self.table.reloadData()
    }
    
    //MARK: LifeCycle
    
    var userID: String?
    var areaResult: String?
    var weightResult: String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .darkGray
        self.tabBarController?.tabBar.barTintColor = .white
        /*
        if traitCollection.userInterfaceStyle == .dark {
            VCTitle.textColor = .white
        }else{
            VCTitle.textColor = .black
        }
        */
        
        //MARK: unit
        
        areaResult = UserDefaults.standard.object(forKey: "areaResultUnit") as? String ?? "10000.00"
        weightResult = UserDefaults.standard.object(forKey: "weightResultUnit") as? String ?? "1.00"
        
        
        //Make PayWall for USER not already logged in
        var sub: Bool?
        
        Task { @MainActor in
            do { let shared = try await AppTransaction.shared
                
                if case .verified(let appTransaction) = shared {
                    let newBusinessModel = "2"
                    
                    let VersionComponents = appTransaction.originalAppVersion.split(separator: ".")
                    
                    let FirstVersionComponent = VersionComponents[0]
                    if FirstVersionComponent < newBusinessModel {
                        
                        
                        print("Already Purchased!")
                        
                    }else{
      
                        Purchases.shared.getCustomerInfo{ (customerInfo, error) in
                            if customerInfo?.entitlements[Costants.entitlementID]?.isActive == true {
                                print("User with Active Sub...")
                                sub = true
                            }else{
                                let nextVC = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "paywall") as! PayWall
                                nextVC.modalPresentationStyle = .automatic
                                
                                self.navigationController?.pushViewController(nextVC, animated: true)
                            }
                        }
                        
                    }
                }
                
            }
            
        }
        
        
        //MARK: Sign IN
        
        if UserDefaults.standard.object(forKey: "userInfo") == nil || sub == false {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            UserDefaults.standard.setValue(user.uid, forKey: "userInfo")
            self.userID = user.uid
            if isAnonymous == true {
                print("User is signed in with UID \(user.uid)")
                }
            }
        }else{
            print("USER ALREADY LOGGED IN!!!")
            
        }
        userID = UserDefaults.standard.object(forKey: "userInfo") as? String
    
        
        
        Task {
            await queryFirestoreField()
            await queryFertilization()
        }
        
    }
    
    
    
    //MARK: func for dispatch
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadLine = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadLine){
            completion()
        }
    }
    
    
    let monitor =  NWPathMonitor()  //MARK: Network checking
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        table.dataSource = self
        table.delegate = self
        self.table.rowHeight = 242
        overrideUserInterfaceStyle = .light
        
        // Add Refresh Control to Table View
                if #available(iOS 10.0, *) {
                    table.refreshControl = refreshControl
                } else {
                    table.addSubview(refreshControl)
                }
        
        
        //add method to refresh data
                refreshControl.addTarget(self, action: #selector(self.refreshTable), for: .valueChanged)
                
                //Setting the tint Color of the Activity Animation
                refreshControl.tintColor = UIColor.systemGray
                
                //Setting the attributed String to the text
                let refreshString = NSMutableAttributedString(string: "Please wait loading...")
                refreshString.addAttribute(.foregroundColor, value: UIColor.systemGray,
                                           range: NSRange(location: 0, length: 6))
                refreshString.addAttribute(.foregroundColor, value: UIColor.systemGray,
                                           range: NSRange(location: 7, length: 4))
                refreshString.addAttribute(.foregroundColor, value: UIColor.systemGray,
                                           range: NSRange(location: 12, length: 10))
                refreshControl.attributedTitle = refreshString
    
        
        //NETWORK Checking
        
        var isConnected: Bool?
        
        let queue = DispatchQueue(label: "Monitor")
           monitor.start(queue: queue)
           monitor.pathUpdateHandler = { path in

               if path.status == .satisfied {
                   print("We're connected!")
                   isConnected = true
                   
               } else {
                   print("No connection.")
                   isConnected = false
               }
           }
        
        if isConnected == false {
        
        pullToRefreshLabel.backgroundColor = .systemTeal
        self.pullToRefreshLabel.textColor = .white
        self.pullToRefreshLabel.text = String("⏬ Pull Down To Refresh ⏬")
        }
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        whole.removeAll()
        chartDataEntry.removeAll()
        fertilization.removeAll()
        n = 0
        p = 0
        k = 0
        mg = 0
        ca = 0
    }
    
    
    @objc func refreshTable(toRefresh sender: UIRefreshControl?) {
            
            //do work off the main thread
            //DispatchQueue.global(qos: .default).async(execute: {
            
                // Simulate network traffic (sleep for 1 seconds)
                //Thread.sleep(forTimeInterval: 1)
                
                //Update data
        whole.removeAll()
        
        Task {
            await queryFirestoreField()
            
        }
      
        run(after: 1){
            print("QUESTO E' WHOLE \(self.whole)")
            self.table.reloadData()
        }
                
                
                //Call complete on the main thread
                //DispatchQueue.main.sync(execute: {
                    print("all done here...")
                    //sender?.endRefreshing()
                    self.table.reloadData()
               // })
            //})
        refreshControl.endRefreshing()
        
        }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
        }

    
    //MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return whole.count
    }

    
    var chartDataEntry = [BarChartDataEntry]()
    var n: Double = 0
    var p: Double = 0
    var k: Double = 0
    var mg: Double = 0
    var ca: Double = 0
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        cell.nameLabel.text = String(" \(whole[indexPath.row].name)")
        cell.dataLabel.text = String("GROWING: \(whole[indexPath.row].growing)")
        cell.areaLabel.text = String("AREA: \(whole[indexPath.row].area) Ha ")
        
        //MARK: chart
     
        chartDataEntry.removeAll()
         n = 0
         p = 0
         k = 0
         mg = 0
         ca = 0
        
        for u in fertilization {
            if u.FID == whole[indexPath.row].DID {
                
                //NITROGEN
                let nit = Double(u.nitrogen) ?? 0
                let q = Double(u.quantity) ?? 0
                n += (q/100)*nit
                //PHOSPHORUS
                let pho = Double(u.phosphorus) ?? 0
                p += (q/100)*pho
                //POTASSIUM
                let pot = Double(u.potassium) ?? 0
                k += (q/100)*pot
                //MAGNESIUM
                let mag = Double(u.magnesium) ?? 0
                mg += (q/100)*mag
                //CALCIUM
                let cal = Double(u.calcium) ?? 0
                ca += (q/100)*cal
            }
        }
        
        let yValue = [n, p, k, mg, ca]
        let xValue = ["N", "P", "K", "Mg", "Ca"]
        
        for u in 0..<yValue.count {
            let value = BarChartDataEntry(x: Double(u), y: yValue[Int(u)])
            chartDataEntry.append(value)
        }
        
        let chartDSet = BarChartDataSet(entries: chartDataEntry)
        let barChartData = BarChartData(dataSets: [chartDSet])
        chartDSet.colors = ChartColorTemplates.colorful()
        chartDSet.stackLabels = ["N", "P", "K", "Mg", "Ca"]
        cell.chartView.leftAxis.drawGridLinesEnabled = false
        cell.chartView.rightAxis.drawGridLinesEnabled = false
        cell.chartView.xAxis.drawGridLinesEnabled = false
        cell.chartView.leftAxis.enabled = false
        cell.chartView.rightAxis.enabled = false
        cell.chartView.legend.enabled = false
        cell.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValue)
        cell.chartView.xAxis.labelCount = xValue.count
        cell.chartView.xAxis.labelFont = .boldSystemFont(ofSize: 15)
        cell.chartView.xAxis.labelPosition = .bottom
        
        //let BCD = BarChartData(dataSet: chartDSet)
        //cell.chartView.data = BCD
        cell.chartView.drawGridBackgroundEnabled = false
        
        //Set lineChart for Fertilization Limit
        
        let nLimit = Double(whole[indexPath.row].nitrogenLimit) ?? 0
        let pLimit = Double(whole[indexPath.row].phosphorusLimit) ?? 0
        let kLimit = Double(whole[indexPath.row].potassiumLimit) ?? 0
        let mgLimit = Double(whole[indexPath.row].magnesiumLimit) ?? 0
        let caLimit = Double(whole[indexPath.row].calciumLimit) ?? 0
        
        var yVals1 = [ChartDataEntry]()
        
        let yVals = [nLimit, pLimit, kLimit, mgLimit, caLimit]
        
        for i in 0..<yVals.count {
                let val1 = (Double) (arc4random_uniform(2000))
            yVals1.append(ChartDataEntry(x: val1, y: Double(i)))
            }
        
        //let lineDataSet = LineChartDataSet(yVals: yVals1, label: "Fertilization limit")
           let lineDataSet = LineChartDataSet(entries: yVals1, label: "Fertilization Limit")
           lineDataSet.drawValuesEnabled = false
           lineDataSet.lineWidth = 3
           lineDataSet.drawFilledEnabled = false
           lineDataSet.fillColor = UIColor(red: 186/255, green: 194/255, blue: 195/255, alpha: 1)
           lineDataSet.fillAlpha = 0.5
           
        let lineChartDataSet = LineChartDataSet(entries: yVals1, label: "Fertilization Limit")
        let lineChartData = LineChartData(dataSets: [lineChartDataSet])
        
        //cell.chartView.data = lineChartData
        
        let combinedData = CombinedChartData()
        combinedData.lineData = lineChartData
        combinedData.barData = barChartData
        cell.chartView.data = combinedData
        //cell.chartView.notifyDataSetChanged()
        
        cell.chartView.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    var selectedID: String?
    var selectedNAME: String?
    var selectedAREA: String?
    var selectedGROWING: String?
    var selectedN: String?
    var selectedPH: String?
    var selectedPO: String?
    var selectedCA: String?
    var selectedMG: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedID = whole[indexPath.row].DID
        selectedNAME = whole[indexPath.row].name
        selectedAREA = whole[indexPath.row].area
        selectedGROWING = whole[indexPath.row].growing
        selectedN = whole[indexPath.row].nitrogenLimit
        selectedPH = whole[indexPath.row].phosphorusLimit
        selectedPO = whole[indexPath.row].potassiumLimit
        selectedCA = whole[indexPath.row].calciumLimit
        selectedMG = whole[indexPath.row].magnesiumLimit
        
        performSegue(withIdentifier: "selected", sender: nil)
        table.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let docID = whole[indexPath.row].DID
            
            db.collection("FarmField").document(docID).delete()
            
            whole.remove(at: indexPath.row)
            
            table.deleteRows(at: [indexPath], with: .fade)
            
            table.reloadData()
            
        }
    }
    
    
    
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selected" {
            
            let nextVC = segue.destination as! FieldViewController
            nextVC.docID = selectedID
            nextVC.fieldNAME = selectedNAME
            nextVC.fieldAREA = selectedAREA
            nextVC.fieldGROWING = selectedGROWING
            nextVC.fieldN = selectedN
            nextVC.fieldPH = selectedPH
            nextVC.fieldPO = selectedPO
            nextVC.fieldCA = selectedCA
            nextVC.fieldMG = selectedMG
        }
    }
    

    
}

extension String {
    mutating func replace(_ originalString:String, with newString:String) {
        self = self.replacingOccurrences(of: originalString, with: newString)
    }
}
