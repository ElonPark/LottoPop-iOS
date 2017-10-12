//
//  PrHttpRequest.swift
//  LottoPop
//
//  Created by 구홍석 on 2017. 8. 27..
//  Copyright © 2017년 Prangbi. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class PrHttpRequest {
    // MARK: Constant
    static let API_URL = SERVER_URL + "/common.do"
    
    // MARK: GET
    func getNLottoNumber(drwNo: Int, success: ((NLottoWinResult?) -> Void)?, failure: ((String?) -> Void)?) {
        let urlStr = PrHttpRequest.API_URL + "?method=getLottoNumber&drwNo=" + (0 < drwNo ? String(drwNo) : "")
        Alamofire.request(urlStr)
            .responseJSON { (alamoResponse) in
                switch alamoResponse.result {
                case .success(let resultJson):
                    let responseData = Mapper<NLottoWinResult>().map(JSONObject: resultJson)
                    success?(responseData)
                case .failure(let error):
                    failure?(error.localizedDescription)
                }
        }
    }
    
    func getPLottoNumber(round: Int, success: ((Array<PLottoWinResult>?) -> Void)?, failure: ((String?) -> Void)?) {
        let urlStr = PrHttpRequest.API_URL + "?method=get520Number&drwNo=" + (0 < round ? String(round) : "")
        Alamofire.request(urlStr)
            .responseJSON { (alamoResponse) in
                switch alamoResponse.result {
                case .success(let resultJson):
                    let rows = (resultJson as? [String: Any])?["rows"]
                    let responseData = Mapper<PLottoWinResult>().mapArray(JSONObject: rows)
                    success?(responseData)
                case .failure(let error):
                    failure?(error.localizedDescription)
                }
        }
    }
}
