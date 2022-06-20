//
//  CityList.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

//공주, 광주(전라남도), 구미, 군산, 대구, 대전, 목포, 부산, 서산,
//서울, 속초, 수원, 순천, 울산, 익산, 전주, 제주시, 천안, 청주, 춘천

import Foundation

enum CityList {
    case 공주, 광주, 구미, 군산, 대구, 대전, 목포, 부산, 서산, 서울, 속초, 수원, 순천, 울산, 익산, 전주, 제주시, 천안, 청주, 춘천
    var value: String {
        switch self {
        case .공주:
            return "gongju"
        case .광주:
            return "gwangju"
        case .구미:
            return "gumi"
        case .군산:
            return "gunsan"
        case .대구:
            return "daegu"
        case .대전:
            return "daejeon"
        case .목포:
            return "mokpo"
        case .부산:
            return "busan"
        case .서산:
            return "seosan"
        case .서울:
            return "seoul"
        case .속초:
            return "sokcho"
        case .수원:
            return "suwon"
        case .순천:
            return "suncheon"
        case .울산:
            return "ulsan"
        case .익산:
            return "iksan"
        case .전주:
            return "jeonju"
        case .제주시:
            return "jeju"
        case .천안:
            return "cheonan"
        case .청주:
            return "cheongju"
        case .춘천:
            return "chuncheon"
        }
    }
}
