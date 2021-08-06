//
//  CharacterViewController.swift
//  BreakingBadDemo
//
//  Created by Juan Kruger
//

import UIKit
import SDWebImage

class CharacterViewController: UIViewController {

    private var viewModel: CharacterViewModel?
    
    private var contentGuide: UILayoutGuide!
    private var occupationLabel, statusLabel, nicknameLabel, seasonsLabel: UILabel!
    
    private let scrollView = UIScrollView()
    private let posterImageView = UIImageView()
    
    init(characterViewModel: CharacterViewModel) {
        
        super.init(nibName: nil, bundle: nil)
        viewModel = characterViewModel
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        contentGuide = view.readableContentGuide
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor)])
        
        // Poster
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
                posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
                posterImageView.heightAnchor.constraint(equalToConstant: 200),
                posterImageView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
                posterImageView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor)])
        
        // Occupation
        var headerLabel = addheaderLabelabel(title: NSLocalizedString("Occupation", comment: ""), topView: posterImageView, contentStyle: .full)
        occupationLabel = addDetailLabel(text: "", topView: headerLabel, contentStyle: .full)
        occupationLabel.accessibilityIdentifier = "occupationLabel"
        
        // Status
        headerLabel = addheaderLabelabel(title: NSLocalizedString("Status", comment: ""), topView: occupationLabel, contentStyle: .full)
        statusLabel = addDetailLabel(text: "", topView: headerLabel, contentStyle: .full)
        
        // Nickname
        headerLabel = addheaderLabelabel(title: NSLocalizedString("Nickname", comment: ""), topView: statusLabel, contentStyle: .halfLeft)
        nicknameLabel = addDetailLabel(text: "", topView: headerLabel, contentStyle: .halfLeft)
        
        // Seasons
        headerLabel = addheaderLabelabel(title: NSLocalizedString("Seasons", comment: ""), topView: statusLabel, contentStyle: .halfRight)
        seasonsLabel = addDetailLabel(text: "", topView: headerLabel, contentStyle: .halfRight)
        
        seasonsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        createBindings()
    }
    
    // MARK: - Custom
    func createBindings() {
        
        viewModel?.name.bind { [weak self] name in
            self?.title = name
        }
        
        viewModel?.imageURLString.bind { [weak self] imgURLString in
            if let imageURL = URL(string: imgURLString) {
            
                self?.posterImageView.sd_setImage(with: imageURL, completed: nil)
            }
            else {
                
                self?.posterImageView.image = nil
            }
        }
        
        viewModel?.status.bind { [weak self] status in
            self?.statusLabel.text = status
        }
        
        viewModel?.occupation.bind { [weak self] occupation in
            self?.occupationLabel.text = occupation
        }
        
        viewModel?.seasons.bind { [weak self] seasons in
            self?.seasonsLabel.text = seasons
        }
        
        viewModel?.nickName.bind { [weak self] nickName in
            self?.nicknameLabel.text = nickName
        }
    }
    
    func addDetailLabel(text :String, topView: UIView, contentStyle: ContentStyle) -> UILabel {
        
        let detailL = UILabel()
        detailL.translatesAutoresizingMaskIntoConstraints = false
        detailL.font = UIFont.systemFont(ofSize: 16)
        detailL.text = text
        detailL.numberOfLines = 0
        detailL.textAlignment = (contentStyle == .halfRight ? .right : .left);
        scrollView.addSubview(detailL)
        
        detailL.topAnchor.constraint(equalTo: topView.bottomAnchor, constant:0).isActive = true
        
        if contentStyle == .full {
            
            NSLayoutConstraint.activate([
                detailL.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
                detailL.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor)])
        }
        else if contentStyle == .halfLeft {
            
            NSLayoutConstraint.activate([
                detailL.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
                detailL.widthAnchor.constraint(equalTo: contentGuide.widthAnchor, multiplier: 0.45)])
        }
        else if contentStyle == .halfRight {
            
            NSLayoutConstraint.activate([
                detailL.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
                detailL.widthAnchor.constraint(equalTo: contentGuide.widthAnchor, multiplier: 0.45)])
        }
        
        return detailL
    }
    
    func addheaderLabelabel(title :String, topView: UIView, contentStyle: ContentStyle) -> UILabel {
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.boldSystemFont(ofSize: 15)
        headerLabel.text = title.uppercased()
        headerLabel.textAlignment = (contentStyle == .halfRight ? .right : .left);
        scrollView.addSubview(headerLabel)
        
        headerLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant:20).isActive = true
        if contentStyle == .full {
            
            NSLayoutConstraint.activate([
                headerLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
                headerLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor)])
        }
        else if contentStyle == .halfLeft {
            
            NSLayoutConstraint.activate([
                headerLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
                headerLabel.widthAnchor.constraint(equalTo: contentGuide.widthAnchor, multiplier: 0.45)])
        }
        else if contentStyle == .halfRight {
            
            NSLayoutConstraint.activate([
                headerLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
                headerLabel.widthAnchor.constraint(equalTo: contentGuide.widthAnchor, multiplier: 0.45)])
        }
        
        return headerLabel
    }
   
    enum ContentStyle {
        case halfLeft
        case halfRight
        case full
    }
}
