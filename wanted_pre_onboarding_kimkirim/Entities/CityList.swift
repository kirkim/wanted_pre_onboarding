//
//  CityList.swift
//  wanted_pre_onboarding_kimkirim
//
//  Created by 김기림 on 2022/06/20.
//

//공주, 광주(전라남도), 구미, 군산, 대구, 대전, 목포, 부산, 서산,
//서울, 속초, 수원, 순천, 울산, 익산, 전주, 제주시, 천안, 청주, 춘천

import Foundation

enum CityList: String, CaseIterable {
    case gongju, gwangju, gumi, gunsan, daegu, daejeon, mokpo, busan, seosan, seoul, sokcho, suwon, suncheon, ulsan, iksan, jeonju, jeju, cheonan, cheongju, chuncheon
    var korean: String {
        switch self {
        case .gongju:
            return "공주"
        case .gwangju:
            return "광주"
        case .gumi:
            return "구미"
        case .gunsan:
            return "군산"
        case .daegu:
            return "대구"
        case .daejeon:
            return "대전"
        case .mokpo:
            return "목포"
        case .busan:
            return "부산"
        case .seosan:
            return "서산"
        case .seoul:
            return "서울"
        case .sokcho:
            return "속초"
        case .suwon:
            return "수원"
        case .suncheon:
            return "순천"
        case .ulsan:
            return "울산"
        case .iksan:
            return "익산"
        case .jeonju:
            return "전주"
        case .jeju:
            return "제주시"
        case .cheonan:
            return "천안"
        case .cheongju:
            return "청주"
        case .chuncheon:
            return "춘천"
        }
    }
}
