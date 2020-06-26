//
//  Firebase.swift
//  Agenda
//
//  Created by Luiz on 26/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit
import Alamofire

class Firebase: NSObject {
    
    func enviaTokenParaServidor(token: String) {
        guard let url = Configuracao().getUrlPadrao() else { return }
        
        Alamofire.request(url + "api/firebase/dispositivo", method: .post, headers: ["token":token]).responseData { (response) in
            if response.error == nil {
                print("TOKEN ENVIADO COM SUCESSO")
            } else {
                print("ERROR: -----")
                print(response.error!)
            }
        }
    }
}
