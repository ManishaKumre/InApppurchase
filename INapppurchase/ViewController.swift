//
//  ViewController.swift
//  INapppurchase
//
//  Created by Manisha Kumre on 27/12/23.
//

import UIKit
import StoreKit

class ViewController: UIViewController,SKPaymentTransactionObserver,SKProductsRequestDelegate {
   
    
    
    enum Product: String,CaseIterable
    {
        case InApppurchase = "com.InApppurchase.test"
        case dewwe = "com.InApppurchase.test.dffsfs"
        case dweew = "com.InApppurchase.test.w32ee3e"
    }
    
    @IBOutlet weak var hello: UIButton!
    
    
    
    
    
    
//    let ProDuctID = "com.InApppurchase.test"
   
    
    
    

    @IBOutlet weak var paynowbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SKPaymentQueue.default().add(self)
    }


    @IBAction func paynowaction(_ sender: Any) {
        if SKPaymentQueue.canMakePayments(){
            let set : Set<String> = [Product.InApppurchase.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate=self
            productRequest.start()
//          let paymentRequest = SKMutablePayment()
//            paymentRequest.productIdentifier = ProDuctID
//            SKPaymentQueue.default().add(paymentRequest)
//        }else {
//            print("üser unable to make payments")
        }
        
    }
    
    @IBAction func tochance(_ sender: Any) {
        if SKPaymentQueue.canMakePayments(){
            let set : Set<String> = [Product.dewwe.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate=self
            productRequest.start()
            
        }
    }
    @IBAction func hello(_ sender: Any) {
        
        if SKPaymentQueue.canMakePayments(){
            let set : Set<String> = [Product.dweew.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate=self
            productRequest.start()
        }
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let oProduct = response.products.first{
            print("product is available ")
            self.purchase(aproduct: oProduct)
        }else{
            print("products is not available")
        }
    }
    
    func purchase(aproduct:SKProduct){
        let payment = SKPayment(product: aproduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
//            if transaction.transactionState == .purchased{
//               print("Transaction Successfull")
//            }else if transaction.transactionState == .failed{
//                print("Transaction Successfull")
//            }
            
            switch transaction.transactionState {
            case .purchasing:
                print("customer is in the process of purchase")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("customer  purchased")
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("customer  purchasing failed")
          
                
            case .restored:
                
                print("customer restore")
            case .deferred:
                
                print("customer deferred")
            default:
                break
            }
        }
    }
}

