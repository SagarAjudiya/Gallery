//
//  HomeVC.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 11/05/24.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var cvImage: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var btnSideMenu: UIButton!
    
    // MARK: - Variable
    private let viewModel = GalleryViewModel()
    private var reqModel = GalleryRequest()
    private var imageList = [Hit]() {
        didSet {
            cvImage.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setUI()
        getImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    // MARK: - IBAction
    @IBAction func btnSideMenuTap(_ sender: UIButton) {
        guard let profileVC = getInstance(ProfileVC.self) else { return }
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

// MARK: - Function
extension HomeVC {
    
    private func setUI() {
        cvImage.delegate = self
        cvImage.dataSource = self
        cvImage.register(UINib(nibName: ImageCell.className, bundle: nil), forCellWithReuseIdentifier: ImageCell.className)
    }
    
    private func getImages() {
        if let galleryList = SessionManager.shared.galleryObject {
            self.loader?.stopAnimating()
            self.imageList = galleryList
        } else {
            viewModel.getGalleryListApi(request: reqModel, showLoader: { [weak self] isLoading in
                guard let self else { return }
                isLoading ? loader.startAnimating() : loader.stopAnimating()
            }, apiClosure: { [weak self] status, message, data in
                guard let self else { return }
                imageList = data?.hits ?? []
                SessionManager.shared.galleryObject = imageList
            })
        }
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.className, for: indexPath) as? ImageCell else { return UICollectionViewCell() }
        cell.galleryResponse = imageList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = getInstance(GalleryVC.self) else { return }
        vc.image = imageList[indexPath.item].largeImageURL
        navigateTo(vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == imageList.count - 1 {
            reqModel.page += 1
            viewModel.getGalleryListApi(request: reqModel, showLoader: { [weak self] isLoading in
                guard let self else { return }
//                isLoading ? loader.startAnimating() : loader.stopAnimating()
            }, apiClosure: { [weak self] status, message, data in
                guard let self else { return }
                imageList.append(contentsOf: data?.hits ?? [])
                SessionManager.shared.galleryObject = imageList
            })
        }
    }

}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    private enum CellConst {
        static let topC = 0.0
        static let leftC = 10.0
        static let bottomC = 0.0
        static let rightC = 10.0
        static let cellheight = 280.0
        static let lineSpace = 30.0
        static let itemSpace = 0.0
        static let cellCount = 2.0
        static let padding = leftC + rightC + lineSpace * (cellCount - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let clcWidth = collectionView.bounds.width
        let size = CGSize(width: (clcWidth - CellConst.padding)/CellConst.cellCount, height: CellConst.cellheight)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CellConst.itemSpace
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CellConst.lineSpace
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CellConst.topC, left: CellConst.leftC, bottom: CellConst.bottomC, right: CellConst.rightC)
    }
    
}
