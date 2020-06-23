//
//  ImagePicker.swift
//  Agenda
//
//  Created by Luiz on 22/06/20.
//  Copyright © 2020 Alura. All rights reserved.
//

import UIKit

enum MenuDeOpcoes {
    case camera
    case biblioteca
}

protocol ImagePickerFotoSelecionada {
    func imagePickerFotoSelecionada(_ foto: UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Atributos
    var delegate: ImagePickerFotoSelecionada?
    
    // MARK: - Métodos
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let foto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        delegate?.imagePickerFotoSelecionada(foto)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func menuDeOpcoes(completion: @escaping(_ opcao: MenuDeOpcoes) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "tirar foto", style: .default, handler: {
            (acao) in
            completion(.camera)
        })
        menu.addAction(camera)
        let biblioteca = UIAlertAction(title: "biblioteca", style: .default, handler: {
            (acao) in
            completion(.biblioteca)
        })
        menu.addAction(biblioteca)
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
    }
}
