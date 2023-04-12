//
//  ViewController.swift
//  BlurView
//
//  Created by Mario on 12/04/23.
//

import UIKit
import BlurView

class ViewController: UIViewController {

  @IBOutlet private weak var blurSlider: UISlider!

  private lazy var contentStackView: UIStackView = {
    let instance = UIStackView()
    instance.translatesAutoresizingMaskIntoConstraints = false
    instance.axis = .vertical
    instance.spacing = 20
    instance.addArrangedSubview(blurAmountLabel)
    instance.addArrangedSubview(imageView)
    return instance
  }()

  private lazy var blurAmountLabel: UILabel = {
    let instance = UILabel()
    instance.textAlignment = .center
    instance.setContentCompressionResistancePriority(.required, for: .horizontal)
    instance.setContentCompressionResistancePriority(.required, for: .vertical)
    instance.setContentHuggingPriority(.required, for: .horizontal)
    instance.setContentHuggingPriority(.required, for: .vertical)
    return instance
  }()

  private lazy var imageView: UIImageView = {
    let instance = UIImageView()
    instance.translatesAutoresizingMaskIntoConstraints = false
    instance.image = UIImage(systemName: "bubbles.and.sparkles.fill")
    instance.heightAnchor.constraint(equalToConstant: 200).isActive = true
    instance.widthAnchor.constraint(equalToConstant: 200).isActive = true
    instance.contentMode = .scaleAspectFit
    instance.tintColor = .orange
    return instance
  }()

  private lazy var blurView: BlurView = {
    let instance = BlurView(contentView: contentStackView)
    instance.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(instance)
    NSLayoutConstraint.activate([
      instance.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      instance.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    return instance
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setInitialBlur()
  }

  private func setInitialBlur() {
    blurSlider.value = 0.33
    sliderValueDidChange(blurSlider)
  }

  @IBAction private func sliderValueDidChange(_ slider: UISlider) {
    let blur = CGFloat(slider.value * 10)
    blurAmountLabel.text = "blur = \(blur)"
    blurView.blurRadius = CGFloat(slider.value * 10)
  }
}

