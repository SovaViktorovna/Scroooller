//
//  OAuthTokenResponseBody.swift
//  Scroooller
//
//  Created by Виктория Демченко on 04.07.24.
//

import UIKit
struct OAuthTokenResponseBody: Codable {
    let access_token: String
    let token_type: String
    let scope: String
    let created_at: Int
    
    
  }
