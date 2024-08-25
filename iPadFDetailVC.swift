//
//  iPadFDetailVC.swift
//  Fertilizer Calc App
//
//  Created by Alberto Giambone on 20/04/24.
//

import UIKit
import Firebase
import DGCharts

class iPadFDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var refreshControl = UIRefreshControl()
    
    //MARK: var from homeVC
    
    var docID: String?
    var fieldNAME:String?
    var fieldAREA: String?
    var fieldGROWING: String?
    
    var fieldN: String?
    var fieldPH: String?
    var fieldPO: String?
    var fieldCA: String?
    var fieldMG: String?
    
    
    //MARK: Connection
    
    @IBOutlet weak var NAME: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var quantityLimit: UILabel!
    
    @IBOutlet weak var differenceLabel: UILabel!
    
    
    //MARK: query Firestore
    
    let db = Firestore.firestore()
    var fert = [Fertilization]()
    
    func queryFirestore() async {
  
        do {
            let querySnapshot = try await db.collection("Ferilization").whereField("FID", isEqualTo: docID!).getDocuments()
            for document in querySnapshot.documents {
                let y = Fertilization(nitrogen: document.data()["nitrogen"] as? String ?? "", phosphorus: document.data()["phosphorus"] as? String ?? "", potassium: document.data()["potassium"] as? String ?? "", calcium: document.data()["calcium"] as? String ?? "", magnesium: document.data()["magnesium"] as? String ?? "", quantity: document.data()["quantity"] as? String ?? "", date: document.data()["date"] as? String ?? "", UID: document.data()["UID"] as? String ?? "", FID: document.data()["FID"] as? String ?? "", DID: document.documentID)
                
                self.fert.append(y)
            }
        } catch let err {
            print("Error getting documents: \(err)")
        }
        
    }
    
    //MARK: func for dispatch
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadLine = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadLine){
            completion()
        }
    }
    
    //MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
    
        self.navigationController?.navigationBar.tintColor = .darkGray
        
        
        Task {
            await queryFirestore()
            self.table.reloadData()
            self.totalUnit()
        }
        
        
        
        
        /*
        let group = DispatchGroup()
        group.enter()
          
        DispatchQueue.global(qos: .default).sync {
            queryFirestore()
            self.table.reloadData()
            group.leave()
        }
    
    group.wait()
        
        run(after: 1){
            print("QUESTO E' WHOLE \(self.fert)")
            self.table.reloadData()
            self.totalUnit()
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NAME.text = fieldNAME
        
        table.dataSource = self
        table.delegate = self
        table.rowHeight = 100
        //resultBackgroundlabel.layer.cornerRadius = 15
        overrideUserInterfaceStyle = .light
        //self.navigationController?.navigationBar.tintColor = .systemTeal

        run(after: 1){
            print("QUESTO E' WHOLE \(self.fert)")
            self.table.reloadData()
        }
        
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
    }
    
    @objc func refreshTable(toRefresh sender: UIRefreshControl?) {
            
            //do work off the main thread
            //DispatchQueue.global(qos: .default).async(execute: {
            
                // Simulate network traffic (sleep for 1 seconds)
                //Thread.sleep(forTimeInterval: 1)
        fert.removeAll()
                //Update data
        
        Task {
            await queryFirestore()
            self.table.reloadData()
        }
        
        /*
        let group = DispatchGroup()
        group.enter()
          
        DispatchQueue.global(qos: .default).sync {
            queryFirestore()
            self.table.reloadData()
            group.leave()
        }
    
    group.wait()
         */
                
                //Call complete on the main thread
                //DispatchQueue.main.sync(execute: {
                    print("all done here...")
                    //sender?.endRefreshing()
                    self.table.reloadData()
               // })
            //})
        refreshControl.endRefreshing()
        

    }

    override func viewDidDisappear(_ animated: Bool) {
        fert.removeAll()
        azoto = 0.00
        fosforo = 0.00
        potassio = 0.00
    }
    
    //MARK: func for FERT Amount
    
    var azoto = 0.00
    var fosforo = 0.00
    var potassio = 0.00
    var magnesio = 0.00
    var calcio = 0.00
    
    func totalUnit() {
        
        for n in fert {
            
            let a = Double(n.nitrogen) ?? 0.00
            let q = Double(n.quantity) ?? 0.00
            let unit = (q/100)*a
            
            azoto += unit
            
            let p = Double(n.phosphorus) ?? 0.00
            fosforo += (q/100)*p
            
            let po = Double(n.potassium) ?? 0.00
            potassio += (q/100)*po
            print("ECCO A:    \(a)")
            
            let mg = Double(n.magnesium) ?? 0.00
            magnesio += (q/100)*mg
            
            let ca = Double(n.calcium) ?? 0.00
            calcio += (q/100)*ca
        }
        
        resultLabel.text = String("N: \(azoto.truncate(places: 2)) P: \(fosforo.truncate(places: 2)) K: \(potassio.truncate(places: 2)) Mg: \(magnesio.truncate(places: 2)) Ca: \(calcio.truncate(places: 2))")
        
        var n: Double?
        var p: Double?
        var po: Double?
        var mg: Double?
        var ca: Double?
        n = Double(fieldN!) ?? 0.00
        p = Double(fieldPH!) ?? 0.00
        po = Double(fieldPO!) ?? 0.00
        mg = Double(fieldMG!) ?? 0.00
        ca = Double(fieldCA!) ?? 0.00
        
        quantityLimit.text = String("N: \(n!) P: \(p!) K: \(po!) Mg: \(mg!) Ca: \(ca!)")
    }
    
    //MARK: tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fert.count
    }

    var chartDataEntry = [BarChartDataEntry]()
    var yValue = [Double]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! iPadFdTvCell
        yValue.removeAll()
        cell.dateLabel.text = fert[indexPath.row].date
        cell.nitrogenLabel.text = String("N \(fert[indexPath.row].nitrogen)")
        cell.phosphorusLabel.text = String("P \(fert[indexPath.row].phosphorus)")
        cell.potassiumLabel.text = String("K \(fert[indexPath.row].potassium)")
        cell.magnesiumLabel.text = String("Mg \(fert[indexPath.row].magnesium)")
        cell.calciuLabel.text = String("Ca \(fert[indexPath.row].calcium)")
        cell.quantityLabel.text = String("\(fert[indexPath.row].quantity) Kg/Ha")

        //MARK: Chart settings
        
        let q = Double(fert[indexPath.row].quantity) ?? 0
        
        let n = Double(fert[indexPath.row].nitrogen) ?? 0
        let p = Double(fert[indexPath.row].phosphorus) ?? 0
        let k = Double(fert[indexPath.row].potassium) ?? 0
        let mg = Double(fert[indexPath.row].magnesium) ?? 0
        let ca = Double(fert[indexPath.row].calcium) ?? 0
        
        let n_0 = (q/100) * n
        let p_0 = (q/100) * p
        let k_0 = (q/100) * k
        let mg_0 = (q/100) * mg
        let ca_0 = (q/100) * ca
        
        yValue = [n_0, p_0, k_0, mg_0, ca_0]
        chartDataEntry.removeAll()
        for u in 0..<yValue.count {
            let value = BarChartDataEntry(x: Double(u), y: yValue[Int(u)])
            chartDataEntry.append(value)
        }
        
        let chartDSet = BarChartDataSet(entries: chartDataEntry)
        chartDSet.colors = [UIColor(red: 64/255, green: 160/255, blue: 64/255, alpha: 1), UIColor(red: 64/255, green: 160/255, blue: 64/255, alpha: 1)]
        //chartDSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1), UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        //chartDSet.stackLabels = ["N", "P", "K", "Mg", "Ca"]
        
        let xLabel = ["N", "P", "K", "Mg", "Ca"]
        
        let BCD = BarChartData(dataSets: [chartDSet])
        cell.chartView.data = BCD
        
        cell.chartView.leftAxis.drawGridLinesEnabled = false
        cell.chartView.rightAxis.drawGridLinesEnabled = false
        cell.chartView.xAxis.drawGridLinesEnabled = false
        cell.chartView.leftAxis.enabled = false
        cell.chartView.rightAxis.enabled = false
        cell.chartView.legend.enabled = false
        cell.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xLabel)
        cell.chartView.xAxis.labelCount = 5
        cell.chartView.xAxis.labelFont = .boldSystemFont(ofSize: 15)
        cell.chartView.xAxis.labelPosition = .bottom
    
        //let BCD = BarChartData(dataSet: chartDSet)
        
        cell.chartView.drawGridBackgroundEnabled = false
        cell.chartView.isUserInteractionEnabled = false
        cell.chartView.animate(xAxisDuration: 1, yAxisDuration: 1)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            db.collection("Ferilization").document(fert[indexPath.row].DID).delete()
            
            fert.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .fade)
            
            table.reloadData()
            
            azoto = 0.00
            fosforo = 0.00
            potassio = 0.00
            
            totalUnit()
        }
    }
    
    var fertID: String?
    var fertUID: String?
    var fertFID: String?
    var Fdate: String?
    var Fn: String?
    var Fp: String?
    var Fpo: String?
    var Fm: String?
    var Fc: String?
    var Fq: String?
    var Fname: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        fertID = fert[indexPath.row].DID
        fertUID = fert[indexPath.row].UID
        fertFID = fert[indexPath.row].FID
        Fdate = fert[indexPath.row].date
        Fn = fert[indexPath.row].nitrogen
        Fp = fert[indexPath.row].phosphorus
        Fpo = fert[indexPath.row].potassium
        Fm = fert[indexPath.row].magnesium
        Fc = fert[indexPath.row].calcium
        Fq = fert[indexPath.row].quantity
        Fname = fieldNAME
        
        performSegue(withIdentifier: "editFert", sender: nil)
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editFieldSettings" {
            
            let nextVC = segue.destination as! iPadFieldSettingsVC
            nextVC.fieldID = docID
            nextVC.fieldName = fieldNAME
            nextVC.fieldGrowing = fieldGROWING
            nextVC.N = fieldN
            nextVC.PH = fieldPH
            nextVC.PO = fieldPO
            nextVC.CA = fieldCA
            nextVC.MG = fieldMG
            nextVC.fieldAREA = fieldAREA
            
        }
        if segue.identifier == "newFert" {
            
            let nextVC = segue.destination as! iPadAddFertilizationVC
            nextVC.fieldID = docID
            nextVC.fieldName = fieldNAME
        }
        if segue.identifier == "editFert" {
            let nextVC = segue.destination as! iPadAddFertilizationVC
            nextVC.fielDID = fertID
            nextVC.fertUID = fertUID
            nextVC.fertFID = fertFID
            nextVC.fertDATE = Fdate
            nextVC.fertN = Fn
            nextVC.fertP = Fp
            nextVC.fertPO = Fpo
            nextVC.fertMG = Fm
            nextVC.fertCA = Fc
            nextVC.fertQ = Fq
            nextVC.fieldID = docID
            nextVC.editingMode = true
        }
        
    }
    
    //MARK: Action

    @IBAction func addFertilizationTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "newFert", sender: nil)
    }
    
    @IBAction func FieldSettingsTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "editFieldSettings", sender: nil)
    }
    
    
}

extension NSMutableAttributedString {

    func setColor(color: UIColor, forText stringValue: String) {
       let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}
