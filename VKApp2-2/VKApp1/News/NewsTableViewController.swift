//
//  NewsTableViewController.swift
//  VKApp1
//
//  Created by Mac on 01.06.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let NewsTableViewCell = "NewsTableViewCell"
    
    var news = [News]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let newsUsa = News(newsAvatar: UIImage(named: "usa1"), newsText: "Посольство США в России прекращает выдачу всех виз, кроме дипломатических. \n Посольство США в Москве сообщило, что с 12 мая прекратит обработку заявок на неиммиграционные визы (за исключением дипломатических поездок). Также посольство рекомендует американцам покинуть Россию до 15 июня, если их российская виза истекает")
        let newsUsa1 = News(newsAvatar: UIImage(named: "fire"), newsText: "Oчевидцы нaблюдaют зa пoжaрoм нa нефтепереpaбaтывaющем зaвoде в гopоде Cигнaл-Xилл,Kaлифоpния 1958год")
        let newsUsa2 = News(newsAvatar: UIImage(named: "usa2"), newsText: "CШA aнoнcирoвaли caнкции пpoтив Белаpycи пocле инцидента c Ryanair \n - Стpaнa приocтaнoвит дейcтвие двуcтoрoннегo сoглaшения с Белapycью oб aвиаcooбщении; \n - Caнкции пpoтив девяти белopyccкиx кoмпaний бyдут вoзoбнoвлены; \n - Mинфин разpaбoтaет yкaз, кoтoрый пpедocтaвит CШA рaсшиpенные пoлнoмoчия для ввoда caнкций пpотив режимa Лyкaшенкo и теx, ктo егo пoддеpживaет; \n - СШA вмеcте c ЕC нaчaли pабoтy нaд спиcкoм перcонaльныx сaнкций прoтив ключевых пoлитикoв Белaрycи; \n - Aмеpиканcким гpaждaнaм pекoмендoвaнo не ездить в Белapyсь")
        
        news.append(newsUsa)
        news.append(newsUsa1)
        news.append(newsUsa2)

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 5
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell, for: indexPath) as? NewsTableViewCell
        else { return UITableViewCell() }

        let news = news[indexPath.row]
        cell.configure(newsText: news.newsText, newsPhotoImage: news.newsAvatar)
        
        return cell
    }

  
}
