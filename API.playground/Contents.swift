import UIKit

class API {
    let course  = "https://api.letsbuildthatapp.com/jsondecodable/course"
    let courses = "https://api.letsbuildthatapp.com/jsondecodable/courses"
    let website = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
    let missing = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"

    init() {
        guard let url = URL(string: website) else { return }



//        let newCourse = Course(nil, nil, nil, nil)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = try? JSONEncoder().encode(newCourse)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.timeoutInterval = 60
//        URLSession.shared.dataTask(with: request) { (d, r, e) in
//            guard let d = d else { return }
//            let website = try? JSONDecoder().decode(Website.self, from: d)
//            print("Charles \(website?.courses?.first?.id)")
//        }



        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let website = try? JSONDecoder().decode(Website.self, from: data)
            print("Charles \(website?.courses?.first?.id)")
        }.resume()

        guard let test = try? Data(contentsOf: url) else { return }
        let website = try? JSONDecoder().decode(Website.self, from: test)
        print("Charles \(website?.courses?.first?.name)")
    }
}


class Website: Codable {
    let name        : String?
    let description : String?
    let courses     : [Course]?
}
class Course: Codable {
    let id      : Int?
    let name    : String?
    let link    : String?
    let imgUrl  : String?

    init(_ id: Int?, _ name: String?, _ link: String?, _ imgUrl: String?) {
        self.id     = id
        self.name   = name
        self.link   = link
        self.imgUrl = imgUrl
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case link
        case imgUrl = "imageUrl"
    }
}
API()
