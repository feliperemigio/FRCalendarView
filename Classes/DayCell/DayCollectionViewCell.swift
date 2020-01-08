//
//  DayCollectionViewCell.swift
//  CalendarView
//
//  Created by Felipe Remigio on 14/10/19.
//  Copyright © 2018 tvglobo. All rights reserved.
//

import UIKit

protocol DayCollectionViewCellProtocol: AnyObject {
    var date: Date? { get }
    func select()
    func selectHalfLeft()
    func selectHalfRight()
    func selectHightlight()
    func disable()
}

final class DayCollectionViewCell: UICollectionViewCell {
    private(set) var date: Date?
    private var appearance: CalendarViewAppearance? = nil
    private var selectedView: UIView?
    private var selectedBetweenView: UIView?
    private let sizeSelected = CGSize(width: 34, height: 34)
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    private var borderBottomView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.numberLabel)
        self.numberLabel.anchorCenterSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    private func reset() {
        self.backgroundColor = UIColor.clear
        
        self.numberLabel.backgroundColor = UIColor.clear
        
        selectedView?.removeFromSuperview()
        selectedView = nil
        
        selectedBetweenView?.removeFromSuperview()
        selectedBetweenView = nil
    }
    
    private func createSelectedBackgroundView(withWidth width: CGFloat) {
        selectedBetweenView = UIView()
        selectedBetweenView?.backgroundColor = self.appearance?.tintColor
        selectedBetweenView?.alpha = 0.7
        self.addSubview(selectedBetweenView!)
        selectedBetweenView?.anchor(height: self.sizeSelected.height, width: width)
        selectedBetweenView?.anchorCenterYToSuperview()
        self.sendSubviewToBack(selectedBetweenView!)
    }
    
    private func createBorderBottomView() {
        borderBottomView?.removeFromSuperview()
        borderBottomView = UIView()
        borderBottomView?.backgroundColor = self.appearance?.separatorColor
        self.addSubview(borderBottomView!)
        borderBottomView?.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, insets: UIEdgeInsets())
        borderBottomView?.anchor(height: self.appearance?.separatorHeight, width: nil)
    }
}

extension DayCollectionViewCell: DayCollectionViewCellProtocol {
    
    func select() {
        selectedView = UIView()
        selectedView?.backgroundColor = self.appearance?.tintColor
        selectedView?.layer.cornerRadius = self.sizeSelected.height / 2
        self.addSubview(selectedView!)
        selectedView?.anchorCenterSuperview()
        selectedView?.anchor(height: self.sizeSelected.height, width: self.sizeSelected.width)
        self.sendSubviewToBack(selectedView!)
        
        self.numberLabel.attributedText = NSAttributedString(string: self.numberLabel.text ?? "",
                                                             attributes: self.appearance?.daySelectedTextAttributes)
       
        OperationQueue.main.addOperation {
             self.selectedView?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            UIView.animate(withDuration: 0.15) {
                self.selectedView?.transform = CGAffineTransform.identity
            }
        }
    }
    
    func selectHalfRight() {
        let width = self.frame.size.width / 2
        self.createSelectedBackgroundView(withWidth: width)
        selectedBetweenView?.anchor(leading: self.centerXAnchor)
    }
    
    func selectHalfLeft() {
        let width = self.frame.size.width / 2
        self.createSelectedBackgroundView(withWidth: width)
        selectedBetweenView?.anchor(trailing: self.centerXAnchor)
    }
    
    func selectHightlight() {
        let width = self.frame.size.width
        self.createSelectedBackgroundView(withWidth: width)
        selectedBetweenView?.anchorCenterXToSuperview()
    }
    
    func disable() {
        self.numberLabel.attributedText = NSAttributedString(string: self.numberLabel.text ?? "",
                                                             attributes: self.appearance?.disabledTextAttributes)
    }
    
    func configure(withWeekday weekday: Int) {
        self.date = nil
        let text = Date().shortDayOfWeekByDay(weekday, charactersLimit: self.appearance?.weekDayCharactersLimit ?? 1)
        self.numberLabel.attributedText = NSAttributedString(string: text,
                                                             attributes: self.appearance?.weekdayTextAttributes)
    }
    
    func configure(withDate date: Date?) {
        self.date = date
        let day: String
        
        if let date = date {
            day = String(date.day)
        } else {
            day = ""
        }
        
        self.numberLabel.attributedText = NSAttributedString(string: day,
                                                             attributes: self.appearance?.dayTextAttributes)
    }
}

extension DayCollectionViewCell: AppearanceProtocol {
    func applyAppearance(appearance: CalendarViewAppearance) {
        self.appearance = appearance
        self.createBorderBottomView()
    }
}

