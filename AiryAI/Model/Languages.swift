//
//  Languages.swift
//  AiryAI
//
//  Created by Krish Mittal on 30/03/24.
//

import Foundation

struct Language: Identifiable {
    let id = UUID()
    let name: String
    let code: String
    let flag: String
}

extension Language {
    static let allLanguages: [Language] = [
        Language(name: "Arabic", code: "ar", flag: "🇦🇪"),
        Language(name: "Bengali", code: "bn", flag: "🇧🇩"),
        Language(name: "Bulgarian", code: "bg", flag: "🇧🇬"),
        Language(name: "Chinese", code: "zh", flag: "🇨🇳"),
        Language(name: "Croatian", code: "hr", flag: "🇭🇷"),
        Language(name: "Czech", code: "cs", flag: "🇨🇿"),
        Language(name: "Danish", code: "da", flag: "🇩🇰"),
        Language(name: "Dutch", code: "nl", flag: "🇳🇱"),
        Language(name: "English", code: "en", flag: "🇬🇧"),
        Language(name: "Estonian", code: "et", flag: "🇪🇪"),
        Language(name: "Finnish", code: "fi", flag: "🇫🇮"),
        Language(name: "French", code: "fr", flag: "🇫🇷"),
        Language(name: "German", code: "de", flag: "🇩🇪"),
        Language(name: "Greek", code: "el", flag: "🇬🇷"),
        Language(name: "Hebrew", code: "iw", flag: "🇮🇱"),
        Language(name: "Hindi", code: "hi", flag: "🇮🇳"),
        Language(name: "Hungarian", code: "hu", flag: "🇭🇺"),
        Language(name: "Indonesian", code: "id", flag: "🇮🇩"),
        Language(name: "Italian", code: "it", flag: "🇮🇹"),
        Language(name: "Japanese", code: "ja", flag: "🇯🇵"),
        Language(name: "Korean", code: "ko", flag: "🇰🇷"),
        Language(name: "Latvian", code: "lv", flag: "🇱🇻"),
        Language(name: "Lithuanian", code: "lt", flag: "🇱🇹"),
        Language(name: "Norwegian", code: "no", flag: "🇳🇴"),
        Language(name: "Polish", code: "pl", flag: "🇵🇱"),
        Language(name: "Portuguese", code: "pt", flag: "🇵🇹"),
        Language(name: "Romanian", code: "ro", flag: "🇷🇴"),
        Language(name: "Russian", code: "ru", flag: "🇷🇺"),
        Language(name: "Serbian", code: "sr", flag: "🇷🇸"),
        Language(name: "Slovak", code: "sk", flag: "🇸🇰"),
        Language(name: "Slovenian", code: "sl", flag: "🇸🇮"),
        Language(name: "Spanish", code: "es", flag: "🇪🇸"),
        Language(name: "Swahili", code: "sw", flag: "🇰🇪"),
        Language(name: "Swedish", code: "sv", flag: "🇸🇪"),
        Language(name: "Thai", code: "th", flag: "🇹🇭"),
        Language(name: "Turkish", code: "tr", flag: "🇹🇷"),
        Language(name: "Ukrainian", code: "uk", flag: "🇺🇦"),
        Language(name: "Vietnamese", code: "vi", flag: "🇻🇳")
    ]
}
