class ASHeaderBottleView: UICollectionReusableView {
  lazy var contentView: UIView = UIView()
  lazy var contentBottomView: UIView = UIView()

  lazy var logoImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "OHLogoWhite"))
    imageView.contentMode = .scaleToFill
    return imageView
  }()

  lazy var bottleImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "OHBottle"))
    imageView.contentMode = .scaleToFill
    return imageView
  }()

  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.text = "0"
    titleLabel.textColor = UIColor.theme.homePanel.bottleHeaderText
    titleLabel.font = UIFont(name: "Arial Bold", size: FirefoxHomeHeaderViewUX.bottleHeaderSize) //UIFont.systemFont(ofSize: FirefoxHomeHeaderViewUX.bottleHeaderSize, weight: .bold)
    titleLabel.minimumScaleFactor = 0.6
    titleLabel.numberOfLines = 1
    titleLabel.textAlignment = .center
    titleLabel.adjustsFontSizeToFitWidth = true
    return titleLabel
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(contentView)
    contentView.addSubview(logoImageView)
    contentView.addSubview(contentBottomView)
    contentBottomView.addSubview(titleLabel)
    contentBottomView.addSubview(bottleImageView)

    contentView.snp.makeConstraints { make in
      make.centerX.equalTo(snp.centerX)
      make.centerY.equalTo(snp.centerY).offset(15)
    }

    logoImageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.trailing.greaterThanOrEqualTo(contentView.safeArea.trailing)
      make.leading.greaterThanOrEqualTo(contentView.safeArea.leading)
      make.width.equalTo(277)
      make.height.equalTo(54)
      make.centerX.equalTo(contentView.snp.centerX)
    }

    contentBottomView.snp.makeConstraints { make in
      make.top.equalTo(logoImageView.snp.bottom).offset(0)
      make.bottom.equalToSuperview()
      make.centerX.equalTo(contentView.snp.centerX)
    }

    titleLabel.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview()
      make.leading.equalTo(contentBottomView.safeArea.leading)
      make.trailing.equalTo(bottleImageView.safeArea.leading).offset(-4)
    }

    bottleImageView.snp.makeConstraints { make in
      make.centerY.equalTo(contentBottomView.snp.centerY)
      make.width.equalTo(16.3)
      make.height.equalTo(18.11)
      make.trailing.equalTo(contentBottomView.safeArea.trailing)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
