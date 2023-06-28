//
//  DropDownCellTableViewCell.swift
//  DropDown
//
//  Created by Kevin Hirsch on 28/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//
import UIKit

open class DropDownCell: UITableViewCell {
    
    // UI
    let optionLabel = UILabel()
    var selectedBackgroundColor: UIColor?
    var highlightTextColor: UIColor?
    var normalTextColor: UIColor?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }
    
    private func setView() {
        contentView.addSubview(optionLabel)
        
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            optionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            optionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    override open var isSelected: Bool {
        willSet {
            setSelected(newValue, animated: false)
        }
    }
    
    override open var isHighlighted: Bool {
        willSet {
            setSelected(newValue, animated: false)
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setSelected(highlighted, animated: animated)
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        let executeSelection: () -> Void = { [weak self] in
            guard let `self` = self else { return }
            
            if let selectedBackgroundColor = self.selectedBackgroundColor {
                if selected {
                    self.backgroundColor = selectedBackgroundColor
                    self.optionLabel.textColor = self.highlightTextColor
                } else {
                    self.backgroundColor = .clear
                    self.optionLabel.textColor = self.normalTextColor
                }
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                executeSelection()
            })
        } else {
            executeSelection()
        }
        
        accessibilityTraits = selected ? .selected : .none
    }
    
}

