
import UIKit

class RecommandFoodRecipesViewController: UIViewController {
    
    let loadCompleteCommand : (() -> Void)
    
    let recommandRecipeCount: Int
    let foodName: String
    
    let outerView = UIView()
    let viewDescriptionLabel = UILabel()
    let exitButton = UIButton()
    
    let recommandRecipeScrollView = UIScrollView()
    let recommandRecipeStackView = UIStackView()
    
    init(superViewController: UIViewController, foodName: String, recommandRecipeCount: Int, loadCompleteCommand: @escaping(() -> Void)) {
        self.foodName = foodName
        self.recommandRecipeCount = recommandRecipeCount
        self.loadCompleteCommand = loadCompleteCommand
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 0.4)
        
        self.outerView.translatesAutoresizingMaskIntoConstraints = false
        self.outerView.layer.cornerRadius = 10
        self.outerView.layer.masksToBounds = false
        self.outerView.backgroundColor = .white
        self.view.addSubview(self.outerView)
        
        self.viewDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.viewDescriptionLabel.text = "다음은 '\(self.foodName)' 에 대한 관련 레시피입니다."
        self.viewDescriptionLabel.textColor = .black
        self.viewDescriptionLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        self.viewDescriptionLabel.textAlignment = .center
        self.outerView.addSubview(self.viewDescriptionLabel)
        
        self.exitButton.translatesAutoresizingMaskIntoConstraints = false
        self.exitButton.setImage(UIImage(named: "exit")?.resized(to: CGSize(width: 30, height: 30)), for: .normal)
        self.exitButton.addTarget(self, action: #selector(exitButtonClicked), for: .touchUpInside)
        self.outerView.addSubview(self.exitButton)
        
        self.recommandRecipeScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.recommandRecipeScrollView.showsHorizontalScrollIndicator = false
        self.outerView.addSubview(self.recommandRecipeScrollView)
        
        self.recommandRecipeStackView.translatesAutoresizingMaskIntoConstraints = false
        self.recommandRecipeStackView.axis = .horizontal
        self.recommandRecipeStackView.spacing = 10
        self.recommandRecipeStackView.alignment = .top
        self.recommandRecipeStackView.distribution = .equalSpacing
        self.recommandRecipeScrollView.addSubview(self.recommandRecipeStackView)
        
        NSLayoutConstraint.activate([
            self.outerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.outerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.outerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.outerView.heightAnchor.constraint(equalToConstant: 300),
            
            self.viewDescriptionLabel.centerYAnchor.constraint(equalTo: self.exitButton.centerYAnchor),
            self.viewDescriptionLabel.leadingAnchor.constraint(equalTo: self.outerView.leadingAnchor, constant: 10),
            self.viewDescriptionLabel.trailingAnchor.constraint(equalTo: self.exitButton.leadingAnchor, constant: -10),
            
            self.exitButton.topAnchor.constraint(equalTo: self.outerView.topAnchor, constant: 5),
            self.exitButton.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -5),
            self.exitButton.widthAnchor.constraint(equalToConstant: 40),
            self.exitButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.recommandRecipeScrollView.topAnchor.constraint(equalTo: self.exitButton.bottomAnchor, constant: 20),
            self.recommandRecipeScrollView.leadingAnchor.constraint(equalTo:self.outerView.leadingAnchor, constant: 10),
            self.recommandRecipeScrollView.trailingAnchor.constraint(equalTo: self.outerView.trailingAnchor, constant: -10),
            self.recommandRecipeScrollView.heightAnchor.constraint(equalToConstant: 200),
        
            self.recommandRecipeStackView.heightAnchor.constraint(equalTo: self.recommandRecipeScrollView.heightAnchor),
            self.recommandRecipeStackView.leadingAnchor.constraint(equalTo: self.recommandRecipeScrollView.contentLayoutGuide.leadingAnchor, constant: 10),
            self.recommandRecipeStackView.trailingAnchor.constraint(equalTo: self.recommandRecipeScrollView.contentLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        // recommandRecipeCount 만큼 보여주기
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        CrawlingHelper.instance.crawlingTwobobChaRecipe(foodName: self.foodName, recipeCount: self.recommandRecipeCount, completion: { recommandRecipes in
            
            DispatchQueue.main.async {
                for recommandRecipe in recommandRecipes! {
                    // 각 RecipeView 생성 및 StackView 추가
                    let recipeView = RecipeView(recipeImageURL: recommandRecipe.recipeImageURL!, recipeTitleString: recommandRecipe.recipeName!, recipeDescriptionString: recommandRecipe.recipeDescription!)
                    
                    recipeView.translatesAutoresizingMaskIntoConstraints = false
                    self.recommandRecipeStackView.addArrangedSubview(recipeView)
                }
                dispatchGroup.leave()
            }
        })
        
        dispatchGroup.notify(queue: .main) {
            self.loadCompleteCommand()
            
            self.modalTransitionStyle = .crossDissolve
            self.modalPresentationStyle = .overFullScreen
            superViewController.present(self, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @objc func exitButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
