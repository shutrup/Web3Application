//
//  DaysService.swift
//  WEB3APP
//
//  Created by Шарап Бамматов on 21.05.2023.
//

import Foundation

protocol DaysServiceProtocol {
    func getDays() async -> Result<[Days], RequestError>
    func getDaysList() async -> Result<Dayslist, RequestError>
    func getCountMouth() async -> Result<CountMonth, RequestError>
}

class DaysService: BaseRequest, DaysServiceProtocol {
    func getDays() async -> Result<[Days], RequestError> {
        return await sendRequest(endpoint: DaysEndpoint.getDays, responseModel: [Days].self)
    }

    func getDaysList() async -> Result<Dayslist, RequestError> {
        return await sendRequest(endpoint: DaysEndpoint.getDaysList, responseModel: Dayslist.self)
    }
    
    func getCountMouth() async -> Result<CountMonth, RequestError> {
        return await sendRequest(endpoint: DaysEndpoint.countMouth, responseModel: CountMonth.self)
    }
}
