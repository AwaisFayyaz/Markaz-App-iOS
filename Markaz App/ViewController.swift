//
//  ViewController.swift
//  Markaz App
//
//  Created by BugDev Studios on 11/12/2019.
//  Copyright © 2019 Conovo Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    processCSVFile()
  }

  func processCSVFile() {
    let path = Bundle.main.path(forResource: "file", ofType: "csv")!
    let fileUrl = URL.init(fileURLWithPath: path)
    do {
      
      let data = try Data.init(contentsOf: fileUrl)
      let dataEncoded = String.init(data: data, encoding: String.Encoding.utf8)!
      let dataArray = dataEncoded.components(separatedBy: "\r\n").map({ $0.components(separatedBy: ";") })
      
      var dictBastiDetails = [Int: [BastiDetails]]()
      
      for line in dataArray {
//        print("Line: \(line)")
        let string = line[0]
        let stringParts = string.components(separatedBy: ",")
//        print("Tafseel: \(stringParts)")
//
//        print("صفحہ: \(stringParts[0])")
//        print("بستی کا نام: \(stringParts[1])")
////        print("stringParts[2]: \(stringParts[2])")
//        print("مساجد: \(stringParts[3])")
//        print("جماعتیں: \(stringParts[4])")
//        print("ساتھی: \(stringParts[5])")
//        print("نقشے پر ایڈریس  1 \(stringParts[6])")
//        print("نقشے پر ایڈریس  2 \(stringParts[7])")
//
//        print("\n\n")
        
        let pageNum = stringParts[0]
        let bastiKaNaam = stringParts[1]
        let masjidain = stringParts[3]
        let jamaitain = stringParts[4]
        let saathi = stringParts[5]
        let address1 = stringParts[6]
        let address2 = stringParts[7]
        
        let bastiDetails = BastiDetails.init(pageNum: pageNum, bastiKaNaam: bastiKaNaam, masjidain: masjidain, jamaitain: jamaitain, saathi: saathi, address1: address1, address2: address2)
        guard let pageNumInt = Int(pageNum) else { continue }
        if var arrayBasties = dictBastiDetails[pageNumInt] {
          arrayBasties.append(bastiDetails)
          dictBastiDetails[pageNumInt] = arrayBasties
        }else {
          var arrayBasties = [BastiDetails]()
          arrayBasties.append(bastiDetails)
          dictBastiDetails[pageNumInt] = arrayBasties
        }
      }
      
      for (pageNum, arrayBastis) in dictBastiDetails {
        print("PageNum: \(pageNum)")
        print("arrayBastis: \(arrayBastis)")
        print("\n\n")
      }
//      print("dataEncoded: \(dataArray as Any)")
    }catch {
      print("Error reading csv file")
    }
    
  }

}

struct BastiDetails {
  
  let pageNum : String
  let bastiKaNaam : String
  let masjidain : String
  let jamaitain : String
  let saathi: String
  let address1 : String
  let address2 : String
  
}
