//
//  HomeTableViewCell.swift
//  Agenda
//
//  Created by Luiz Henrique de Souza on 27/06/20.
//  Copyright © Zennit 2020. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageAluno: UIImageView!
    @IBOutlet weak var labelNomeDoAluno: UILabel!
    @IBOutlet weak var viewImagem: UIView!
    
    func configuraCelula(_ aluno:Aluno) {
        labelNomeDoAluno.text = aluno.nome
        viewImagem.layer.cornerRadius = imageAluno.frame.width / 2
        if let imagemDoAluno = aluno.foto as? UIImage {
            imageAluno.image = imagemDoAluno
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
