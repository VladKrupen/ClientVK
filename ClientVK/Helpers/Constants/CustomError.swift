//
//  CustomError.swift
//  ClientVK
//
//  Created by Vlad on 4.12.24.
//

import Foundation

enum CustomError: String, Error {
    case invalidURL = "Проблемы с подключением. Пожалуйста, повторите попытку позже"
    case invalidResponse = "Не удалось обработать запрос. Пожалуйста, повторите попытку позже"
    case somethingWentWrong = "Упс, что-то пошло не так. Пожалуйста, повторите попытку позже"
}
