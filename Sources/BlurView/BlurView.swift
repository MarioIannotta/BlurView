//
//  BlurView.swift
//  BlurView
//
//  Created by Mario on 12/04/23.
//

import UIKit
import SwiftUI

open class BlurView: UIView {

  @ObservedObject
  private var viewModel: BlurViewModel

  private var blurController: BlurHostingViewController

  public var blurRadius: CGFloat = 5 {
    didSet {
      viewModel.blurRadius = blurRadius
      invalidateIntrinsicContentSize()
    }
  }

  private weak var contentView: UIView?

  public init(contentView: UIView) {
    let viewModel = BlurViewModel()
    self.blurController = BlurHostingViewController(viewModel: viewModel, contentView: contentView)
    self.viewModel = viewModel
    self.contentView = contentView
    super.init(frame: .zero)
    setup()
  }

  open override var intrinsicContentSize: CGSize {
    contentView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) ?? .zero
  }

  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    guard let viewToAdd = blurController.view
    else { return }
    viewToAdd.translatesAutoresizingMaskIntoConstraints = false
    viewToAdd.frame = bounds
    addSubview(viewToAdd)
    NSLayoutConstraint.activate([
      viewToAdd.leadingAnchor.constraint(equalTo: leadingAnchor),
      viewToAdd.trailingAnchor.constraint(equalTo: trailingAnchor),
      viewToAdd.topAnchor.constraint(equalTo: topAnchor),
      viewToAdd.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

private class BlurViewModel: ObservableObject {

  @Published
  var blurRadius: CGFloat = 0

}

private class BlurHostingViewController: UIHostingController<BlurredView<BlurViewContent>> {

  init(viewModel: BlurViewModel, contentView: UIView) {
    let blurredView = BlurredView(viewModel: viewModel) {
      BlurViewContent(contentView: contentView)
    }
    super.init(rootView: blurredView)
    view.backgroundColor = .clear
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private struct BlurredView<Content: View>: View {

  @ObservedObject
  var viewModel: BlurViewModel

  private var content: () -> Content

  init(viewModel: BlurViewModel, @ViewBuilder content: @escaping () -> Content) {
    self.viewModel = viewModel
    self.content = content
  }

  var body: some View {
      content()
      .blur(radius: viewModel.blurRadius)
  }
}

private struct BlurViewContent: UIViewRepresentable {

  private var contentView: UIView

  init(contentView: UIView) {
    self.contentView = contentView
  }

  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    view.setContentCompressionResistancePriority(.required, for: .horizontal)
    view.setContentCompressionResistancePriority(.required, for: .vertical)
    view.setContentHuggingPriority(.required, for: .horizontal)
    view.setContentHuggingPriority(.required, for: .vertical)
    view.backgroundColor = .clear
    contentView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(contentView)
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: view.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    return view
  }

  func updateUIView(_ uiView: UIView, context: Context) { }
}
