//
//  OnboardVC.swift
//  ChatApplication
//
//  Created by NAM on 01/10/24.
//

import Foundation
import UIKit

class OnboardVC: BaseVC {
    
    static let name = "OnboardVC"
    static let storyBoard = "Onboard"
    
    /// The caller of this class does not need to know how we instantiate it.
    /// We simply return the instantiated class to the caller and they invoke it how they want
    /// If the as! fails, it will fail upon immediate testing
    class func instantiateFromStoryboard() -> OnboardVC {
        let vc = UIStoryboard(name: OnboardVC.storyBoard, bundle: nil).instantiateViewController(withIdentifier: OnboardVC.name) as! OnboardVC
        return vc
    }
    
    
    // MARK: - IBOutlet Declaration
    
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var onboardingCV: UICollectionView!
    @IBOutlet var getStartV: UIView!
    
    var dataViewModel = OnboardViewModel()
    
    // MARK: - Override Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        registerCollectionViewCells()
        setupViews()
        initViewModel()
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            self.onboardingCV.reloadData()
        }
        dataViewModel.getData()
    }
    
    // MARK: OTHER METHODS
    
    /// Register CollectionView Cell
    func registerCollectionViewCells() {
        let onboardCVCNib = UINib(nibName: "OnboardCVC", bundle: nil)
        onboardingCV.register(onboardCVCNib, forCellWithReuseIdentifier: "OnboardCVC")
    }
    
    
    // MARK: - SetUps
    
    func setupViews() {
        getStartV.setCornerRadius(radius: 8,borderColor: UIColor(hexStr: "E4E7EA") ,borderWidth: 1)

    }
    
    /*================================================================================================================*/
    // MARK: - @IBACtion Methods
    
    @IBAction func actionOnStarted() {
        let loginSignupBVC = LoginSignupVC.instantiateFromStoryboard()
        navigationController?.pushViewController(loginSignupBVC, animated: true)
    }
    
}

/*================================================================================================================*/

extension OnboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardCVC", for: indexPath) as? OnboardCVC else { return UICollectionViewCell() }
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        cell.configureCell(onboard: cellVM)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

/*================================================================================================================*/

extension OnboardVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        dataViewModel.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageController.currentPage = dataViewModel.currentPage
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        dataViewModel.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageController.currentPage = dataViewModel.currentPage
    }
}

