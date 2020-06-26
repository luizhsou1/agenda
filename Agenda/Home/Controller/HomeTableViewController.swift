//
//  HomeTableViewController.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Variáveis
    
    let searchController = UISearchController(searchResultsController: nil)
    var alunoViewController:AlunoViewController?
    var alunos:Array<Aluno> = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuraSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recuperaAlunos()
    }
    
    // MARK: - Métodos
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            alunoViewController = segue.destination as? AlunoViewController
        }
    }
    
    func recuperaAlunos() {
        Repositorio().recuperaAlunos { (listaDeAlunos) in
            self.alunos = listaDeAlunos
            self.tableView.reloadData()
        }
    }
    
    func configuraSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    @objc func abrirActionSheet(_ longPress:UILongPressGestureRecognizer) {
        if longPress.state == .began {
            let alunoSelecionado = alunos[(longPress.view?.tag)!]
            guard let navigation = navigationController else { return }
            let menu = MenuOpcoesAlunos().configuraMenuDeOpcoesDoAluno(navigation: navigation, alunoSelecionado: alunoSelecionado)
            present(menu, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alunos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula-aluno", for: indexPath) as! HomeTableViewCell
        celula.tag = indexPath.row
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(abrirActionSheet(_:)))
        let aluno = alunos[indexPath.row]
        celula.configuraCelula(aluno)
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AutenticacaoLocal().autorizaUsuario(completion: { (autenticado) in
                if autenticado {
                    DispatchQueue.main.async {
                        let alunoSelecionado = self.alunos[indexPath.row]
                        Repositorio().deletaAluno(aluno: alunoSelecionado)
                        self.alunos.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }
            })
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alunoSelecionado = alunos[indexPath.row]
        alunoViewController?.aluno = alunoSelecionado
    }
    
    @IBAction func buttonCalculaMedia(_ sender: UIBarButtonItem) {
        CalculaMediaAPI().calculaMediaGeralDosAlunos(alunos: alunos, sucesso: { (dicionario) in
            if let alerta = Notificacoes().exibeNotificacaoDeMediaDosAlunos(dicionarioDeMedia: dicionario) {
                self.present(alerta, animated: true, completion: nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func buttonLocalizacaoGeral(_ sender: UIBarButtonItem) {
        let mapa = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapa") as! MapaViewController
        navigationController?.pushViewController(mapa, animated: true)
    }
    
    // MARK: - SearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let texto = searchBar.text {
            alunos = Filtro().filtraAlunos(listaDeAlunos: alunos, texto: texto)
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        alunos = AlunoDAO().recuperaAlunos()
        tableView.reloadData()
    }
    
    
}
