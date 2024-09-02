//
//  CrawlingHelper.swift
//  MarketProject
//
//  Created by 한건희 on 8/31/24.
//

import Foundation
import SwiftSoup

class CrawlingHelper {
    public static let instance = CrawlingHelper()
    
    private init() {
        
    }
    
    // 이미지를 불러오는 함수
    public func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        
        task.resume()
    }

    public func crawlingTwobobChaRecipe(foodName: String, recipeCount: Int, completion: @escaping ([RecommandRecipe]?) -> Void) {
        let baseURL = "https://2bob.co.kr/"
        let twoBobFoodListPage = "\(baseURL)search_list.php?a=result_recipe&fKeyValue=\(foodName)"
        
        guard let url = URL(string: twoBobFoodListPage) else {
            completion(nil)
            return
        }
        
        // URLSession을 사용하여 데이터를 비동기적으로 가져옵니다.
        URLSession.shared.dataTask(with: url) { data, response, error in
            // 오류 처리
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            // 데이터가 없거나 HTTP 응답 코드가 200이 아닌 경우 오류 처리
            guard let data = data, (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Invalid response or no data")
                completion(nil)
                return
            }
            
            do {
                // 데이터를 문자열로 변환
                let html = String(data: data, encoding: .utf8)
                
                // HTML 파싱
                guard let htmlString = html else {
                    print("Failed to convert data to string")
                    completion(nil)
                    return
                }
                
                let doc: Document = try SwiftSoup.parse(htmlString)
                
                let headerTitle = try doc.title()
                print(headerTitle)
                
                var recommandRecipes = [RecommandRecipe]()
                
                let recipeElements: Elements = try doc.select("div.search_con").select("ul.clr").select("li")
                
                let showCount = (recipeElements.count < recipeCount) ? recipeElements.count : recipeCount
                
                for recipeElement in recipeElements.array()[...(showCount-1)] {
                    
                    let recipeLinkElement: Elements = try recipeElement.select("a")
                    let imageElement: Elements = try recipeElement.select("img")
                    let recipeTitleElement: Elements = try recipeElement.select("p.b_title")
                    let recipeDescriptionElement: Elements = try recipeElement.select("p.s_title")
                    
                    let recipeLinkString = try recipeLinkElement.first()?.attr("href") ?? ""
                    let fullRecipeLinkString = baseURL + recipeLinkString
                    
                    let recipeImageString = try imageElement.first()?.attr("src") ?? ""
                    let fullRecipeImageString = baseURL + recipeImageString
                    
                    let recipeTitleString = try recipeTitleElement.first()?.text() ?? ""
                    let recipeDescriptionString = try recipeDescriptionElement.first()?.text() ?? ""
                    
                    let recommandRecipe = RecommandRecipe(
                        recipeImageURL: fullRecipeImageString,
                        recipeName: recipeTitleString,
                        recipeDescription: recipeDescriptionString,
                        recipeLink: fullRecipeLinkString
                    )
                    
                    recommandRecipes.append(recommandRecipe)
                }
                
                // 결과를 completion 핸들러로 반환
                completion(recommandRecipes)
                
            } catch {
                print("Error parsing HTML: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchHTML(from url: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            

            let htmlString = String(data: data, encoding: .utf8)
            completion(htmlString)
        }

        task.resume()
    }
}
