# iTunesSearchAPI
Simple App based on Itunes Search API <br />Documentation: https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/#searching


## General
* Able to view artist <br />
* Search artist.
* View last visited Artist.

## List of Artist View
Acquire list of data from base URL : https://itunes.apple.com/search? <br />

### Data handling

fetch data using Alamofire <br />
```
Alamofire.request(API_CONSTANTS.URL.BASE_URL, method: .get, parameters: params).responseJSON
```

Sample response from API in JSON:
```
{
      "collectionPrice" : 9.9900000000000002,
      "releaseDate" : "2009-11-19T08:00:00Z",
      "country" : "AUS",
      "wrapperType" : "track",
      "collectionHdPrice" : 9.9900000000000002,
      "collectionExplicitness" : "notExplicit",
      "discNumber" : 1,
      "discCount" : 1,
      "trackCount" : 5,
      "collectionArtistViewUrl" : "https:\/\/itunes.apple.com\/au\/artist\/sony-pictures-entertainment\/345346702?uo=4",
      "collectionCensoredName" : "The Twilight Saga: The Complete Collection",
      "trackHdRentalPrice" : 4.9900000000000002,
      "trackViewUrl" : "https:\/\/itunes.apple.com\/au\/movie\/the-twilight-saga-new-moon\/id356924097?uo=4",
      "artworkUrl100" : "https:\/\/is3-ssl.mzstatic.com\/image\/thumb\/Video118\/v4\/52\/96\/91\/529691a8-d998-d121-91a8-9d7b7e5cc173\/source\/100x100bb.jpg",
      "artworkUrl60" : "https:\/\/is3-ssl.mzstatic.com\/image\/thumb\/Video118\/v4\/52\/96\/91\/529691a8-d998-d121-91a8-9d7b7e5cc173\/source\/60x60bb.jpg",
      "collectionName" : "The Twilight Saga: The Complete Collection",
      "artistName" : "Chris Weitz",
      "contentAdvisoryRating" : "M",
      "trackHdPrice" : 9.9900000000000002,
      "trackRentalPrice" : 4.9900000000000002,
      "artworkUrl30" : "https:\/\/is3-ssl.mzstatic.com\/image\/thumb\/Video118\/v4\/52\/96\/91\/529691a8-d998-d121-91a8-9d7b7e5cc173\/source\/30x30bb.jpg",
      "previewUrl" : "https:\/\/video-ssl.itunes.apple.com\/itunes-assets\/Video128\/v4\/92\/d9\/c9\/92d9c99a-0782-9e05-21db-4bea787db7b2\/mzvf_178006869530977540.640x362.h264lc.U.p.m4v",
      "trackName" : "The Twilight Saga: New Moon",
      "currency" : "AUD",
      "trackCensoredName" : "The Twilight Saga: New Moon",
      "collectionId" : 994937302,
      "kind" : "feature-movie",
      "collectionViewUrl" : "https:\/\/itunes.apple.com\/au\/movie\/the-twilight-saga-new-moon\/id356924097?uo=4",
      "trackTimeMillis" : 7837600,
      "longDescription" : "Edward Cullen has already rescued Bella from the clutches of one evil vampire, but now, as their daring relationship threatens all that is near and dear to them, they realize their troubles may be just beginning.",
      "primaryGenreName" : "Drama",
      "trackExplicitness" : "notExplicit",
      "collectionArtistId" : 345346702,
      "trackPrice" : 9.9900000000000002,
      "trackNumber" : 2,
      "trackId" : 356924097
    }
```
For each artist proceed to storing each item(`ArtistItem`) to data model (`ArtistModel`)
```
var data: [ArtistItem] = []
let json = JSON(response.result.value)
data = ArtistModel(json: json).artistItems
```
For storing each item to model, response data is processed under `ArtistModel`. ex: `data = ArtistModel(json: json).artistItems` then variable `artistItems`under `ArtistModel` is stored inside `data` which is a subclass of `ArtistItem` <br />
`ArtistModel.swift`:
```
class ArtistModel {
    var artistItems: [ArtistItem] = []

    init(json: JSON) {
        let data = json["results"].arrayValue

        for item in data {
            let trackId = item["trackId"].doubleValue
            let artistName = item["artistName"].stringValue
            let collectionName = item["collectionName"].stringValue
            let trackName = item["trackName"].stringValue
            let artworkUrl = item["artworkUrl100"].url!
            let trackPrice = item["trackPrice"].doubleValue
            let releaseDate = item["releaseDate"].stringValue
            let currency = item["currency"].stringValue
            let primaryGenreName = item["primaryGenreName"].stringValue
            let longDescription = item["longDescription"].stringValue

            artistItems.append(ArtistItem(trackId: trackId, artistName: artistName, collectionName: collectionName, trackName: trackName, artworkUrl: artworkUrl, trackPrice: abs(trackPrice), releaseDate: releaseDate, currency: currency, primaryGenreName: primaryGenreName, longDescription: longDescription))
        }
    }
}
```
Here you see `JSON` is split into array value. `data = json["results"].arrayValue` then stored each item into `var artistItems: [ArtistItem] = []`

Storing each item to ```ArtistItem.swift```: <br />
```
struct ArtistItem {
    let trackId: Double
    let artistName: String
    let collectionName: String
    let trackName: String
    let artworkUrl: URL
    let trackPrice: Double
    let releaseDate: String
    let currency: String
    let primaryGenreName: String
    let longDescription: String
}
```
#### Create Realm Class
For `Realm` here's the class: <br />
`ArtistViewModelRealm.swift`
```
import Foundation
import RealmSwift

class ArtistViewModelRealm: Object {
    @objc dynamic var artistName: String?
    @objc dynamic var collectionName: String?
    @objc dynamic var trackName: String?
    @objc dynamic var artworkUrl: String?
    @objc dynamic var releaseDate: String?
    @objc dynamic var primaryGenreName: String?
    @objc dynamic var longDescription: String?
    @objc dynamic var currency: String?
    @objc dynamic var trackPrice: Double = 0.0
}
```
### Initial View
View last stored screen inside `Realm`, execute `realmData()`
```
func realmData() {
        let vc = storyboard?.instantiateViewController(withIdentifier: Identifiers.VIEWCONTROLLERS.ARTISTVIEWCONTROLLER) as! ArtistViewController
        
        guard let data = realm.objects(ArtistViewModelRealm.self).first else { return }

        artistViewmodel = ArtistViewModel(trackId: 0.0, artistName: data.artistName!, collectionName: data.collectionName ?? "", trackName: data.trackName ?? "", artworkUrl: URL(string: data.artworkUrl!)!, trackPrice: data.trackPrice, releaseDate: data.releaseDate ?? "", currency: data.currency!, primaryGenreName: data.primaryGenreName!, longDescription: data.longDescription!)

        vc.artistViewModel = artistViewmodel
        self.navigationController?.pushViewController(vc, animated: true)
    }
```
If data exist, load data from `Realm` to `var artistViewmodel: ArtistViewModel?` then proceed to display `ArtistViewController`
### Display Data to Table View
Number of cell is based of `data.count`
```
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
```
In each cell, display data from `var data: [ArtistItem] = []` which now contains data from API. <br />
ex.
```
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.CUSTOM_CELL.MAIN_TABLEVIEW_CUSTOMCELL, for: indexPath) as! customCell

        cell.artistName.text = data[indexPath.row].artistName
        
        return cell
```
Upon tapping certain cell: `func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)` <br />
View transitions to `ArtistViewController.swift`
Here's the code:
```
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Identifiers.VIEWCONTROLLERS.ARTISTVIEWCONTROLLER) as! ArtistViewController

        artistViewmodel = ArtistViewModel(trackId: data[indexPath.row].trackId, artistName: data[indexPath.row].artistName, collectionName: data[indexPath.row].collectionName, trackName: data[indexPath.row].trackName, artworkUrl: data[indexPath.row].artworkUrl, trackPrice: data[indexPath.row].trackPrice, releaseDate: data[indexPath.row].releaseDate, currency: data[indexPath.row].currency, primaryGenreName: data[indexPath.row].primaryGenreName, longDescription: data[indexPath.row].longDescription)
    
        vc.artistViewModel = artistViewmodel
        self.navigationController?.pushViewController(vc, animated: true)
    }
```
### Artist View
In artist view I'm introducing `RealmSwift` to persist data, which to store last Artist viewed from screen. <br />
<br />
Upon loading/appear of Artist view: <br />
1. Run `func loadData()` which contains data and set values to outlets i.e `@IBOutlet weak var artistName: UILabel!` <br />
2. Run `loadRealmData()` which is placed under `override func viewWillAppear(_ animated: Bool)`. This is to store/write data to `Realm` <br />
Here's the code: <br />
```
    func loadRealmData(){
        artistRealmModel.artworkUrl = artistViewModel?.artworkUrl.absoluteString
        artistRealmModel.artistName = artistViewModel?.artistName
        artistRealmModel.collectionName = artistViewModel?.collectionName
        artistRealmModel.primaryGenreName = artistViewModel?.primaryGenreName
        artistRealmModel.longDescription = artistViewModel?.longDescription
        artistRealmModel.trackPrice = (artistViewModel?.trackPrice)!
        artistRealmModel.currency = artistViewModel?.currency
        
        do {
            try realm.write {
                realm.add(artistRealmModel)

                //UserDefaults.standard.set(true, forKey: "localData")
            }
        } catch {
            print("error:\(error)")
        }
    }
```
3. Upon exit or `deleteRealmData()`, execute `deleteRealmData()` which deletes all data inside `Realm` <br />
### Search Artist
To search artist a popup view will appear triggered from below code: <br />
```
    @IBAction func searchArtist(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Identifiers.VIEWCONTROLLERS.SEARCH_POPUPVIEW) as! SearchPopupView
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
```
passing data is handled using delegation method. <br />

After user input, modify `Alamofire` parameters with user inputs. Below is the sample code:
```
    func didTapSearch(data: String) {
        params = [API_CONSTANTS.PARAMETERS.TERM:data,
                  API_CONSTANTS.PARAMETERS.COUNTRY.KEY:API_CONSTANTS.PARAMETERS.COUNTRY.VALUE,
                  API_CONSTANTS.PARAMETERS.MEDIA.KEY:API_CONSTANTS.PARAMETERS.MEDIA.VALUE,
                  "all":""]
        requestiTunesData()
        tableView.reloadData()
    }
```
## Design
* Designed using MVC pattern for fast development and easy to debug.
* RealmSwift - Simple to understand and a more programmable approach when creating Database than Swift's Core data
* SwiftyJSON - a must have pod unless you have to implement your own JSON handling
* Alamofire - Higher level of abstraction so you can write less code, many features and works perfect with `SwiftyJSON`
## Built With

* Xcode 10.0
* Swift 4.2
* RealmSwift
* SwiftyJSON
* AlamoFire

## Acknowledgments
* (cagdaseksi): https://github.com/SavEyourc0de/letslearnswift/blob/master/LoadRemoteImageUrl/LoadRemoteImageUrl/ViewController.swift +++Load UIImage using URL
