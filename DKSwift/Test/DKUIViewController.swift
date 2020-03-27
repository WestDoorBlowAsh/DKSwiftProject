//
//  DKUIViewController.swift
//  TXInputMethod
//
//  Created by zw on 2019/4/8.
//  Copyright © 2019年 zhhz. All rights reserved.
//

import UIKit

class DKUIViewController: CABaseViewController {
    
    var submitMoney: Double  = 0 // 要提取多少元钱
    var realCoins: Int = 0 // 要提取多少元钱
    let bangDingView = BangDingView()
    let xiuGaiView   = XiuGaiView()
    let goldBuZuView = GoldBuZu()
//    var exchangeModel: ExchangeModel?
    
    let scrollView = UIScrollView()
    let containerView = UIView()
    
    let goldView = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#FAFAFA")
        $0.layer.cornerRadius = 2
    }
    let expendView = UIView()
    let incomeView = UIView()
    let goldLb = UILabel().then {
        $0.text = "当前金币："
    }
    let balanceLb = UILabel().then {
        $0.text = "可兑换余额："
        $0.textColor = UIColor(hexString: "#7F7F7F")
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    let exchangeView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    let moneyLb = UILabel().then {
        $0.text = "兑换现金"
        $0.isUserInteractionEnabled = true
    }
    let telFeeLb = UILabel().then {
        $0.text = "兑换话费"
        $0.textColor = UIColor(hexString: "#7F7F7F")
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isUserInteractionEnabled = true
    }
    let exchangeLineBackView = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#E6E6E6")
    }
    let selectLine = UIView().then {
        $0.backgroundColor = UIColor.theme
    }
    
    let exchangeMoneyView = UIView()
    let recordBtn = UIButton().then {
        $0.setTitle("提现记录", for: .normal)
        $0.setTitleColor(UIColor(hexString: "#444444"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    let payBackImg = UIImageView().then {
        $0.image = UIImage(named: "exchange_back.png")
        $0.isUserInteractionEnabled = true
        
    }
    let aliPayStatusLb = UILabel().then {
        $0.text = "您尚未绑定支付宝"
        $0.textColor = UIColor(hexString: "#7F7F7F")
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    let bindView = UIView()
    let bindActionLb = UILabel().then {
        $0.text = "立即绑定"
        $0.textColor = UIColor(hexString: "#7F7F7F")
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    let exchangeBalanceFeeView = UIView()
    let telFeeTF = UITextField().then {
        $0.placeholder = "请输入兑换账号"
        $0.textColor = UIColor(hexString: "#7F7F7F")
        $0.keyboardType = .phonePad
    }
    
    let exchangeAmountView = UIView()
    let exchangeAmountLb = UILabel().then {
        $0.text = "兑换金额"
        $0.textColor = UIColor(hexString: "#393735")
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let fl = UICollectionViewFlowLayout().then {
        $0.minimumLineSpacing = 6
        $0.minimumInteritemSpacing = 6
        let width = (screenWidth - 15 * 2 - 6 * 2) / 3 - 1
        $0.itemSize = CGSize(width: width, height: 60)
    }
    var collectionView: UICollectionView?
    
    let attentionView = UIView()
    let exchangeBtn = UIButton().then {
        $0.backgroundColor = .theme
        $0.layer.cornerRadius = 20
        $0.setTitle("立即提现", for: .normal)
    }
    
    let exchangeLb = UILabel().then {
        $0.text = "兑换账号: "
    }
    
    var exchangeType = 1 // 1现金 2话费
    
    var exchangeScrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.contentSize = CGSize(width: screenWidth * 2, height: 0)
        $0.showsHorizontalScrollIndicator = false
    }
    
    let attentionContentLb = UILabel().then {
        $0.text = """
        1.提现申请请在7个工作日左右审批到账；如遇到高峰期，可能延迟到账，请耐心等待。
        2.满足一定条件才可兑换，且每天最多兑换一次
        3.具体到账时间按兑换申请后的提示时间为准
        4.金币兑换成现金的比例会随着平台广告收益浮动
        """
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor(hexString: "#A0A0A0")
        $0.numberOfLines = 0
    }
//
//    @objc func onTapGoldView(tap: UITapGestureRecognizer) {
//        let vw = tap.view
//        if vw === incomeView {
//            // 收入明细
//            FlutterManager.shared.openFlutterPage(route: CAFlutterPageRouter.URL_TASK_RECORD, urlParams: ["param": "1"])
//        } else if vw === expendView {
//            // 支出明细
//            FlutterManager.shared.openFlutterPage(route: CAFlutterPageRouter.URL_TASK_RECORD, urlParams: ["param": "0"])
//        }
//    }
//
//    @objc func exchangeRecord() {
//        let vc = MoneyRecordViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @objc func onTapBindView() {
//        if (userInfo.payee_account?.count ?? 0) > 0 {
//            let vc = BangDingViewController()
//            vc.titleString = "修改支付宝"
//            vc.mobile = userInfo.user_id ?? ""
//            vc.clickAction = { [weak self] (string) in
//                self?.xiuGaiView.isHidden = false
//                self?.xiuGaiView.labInfo.text = string
//            }
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else {
//            let vc = BangDingViewController()
//            vc.titleString = "绑定支付宝"
//            vc.mobile = userInfo.user_id ?? ""
//            vc.clickAction = { [weak self] (string) in
//                //
//                self?.xiuGaiView.isHidden = false
//                self?.xiuGaiView.labInfo.text = string
//            }
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//
//    @objc func onTapExchangeView(tap: UITapGestureRecognizer) {
//
//        let lb = tap.view as! UILabel
//
//        var type = 1
//        if lb === telFeeLb {
//            type = 2
//        }
//
//        updateExchangeView(type)
//    }
//
//    func updateExchangeView(_ type: Int = 1) {
//
//
//        self.exchangeType = type
//
//        UIView.animate(withDuration: 0.5) {
//
//            self.exchangeScrollView.contentOffset = CGPoint(x: CGFloat(self.exchangeType - 1) * screenWidth, y: 0)
//
//            var count = 0
//            if (self.exchangeType == 1) {
//                self.telFeeLb.textColor = UIColor(hexString: "#7F7F7F")
//                self.telFeeLb.font = UIFont.systemFont(ofSize: 16)
//                self.moneyLb.textColor = UIColor(hexString: "#313131")
//                self.moneyLb.font = UIFont.systemFont(ofSize: 18)
//                self.exchangeAmountView.snp.remakeConstraints {
//                    $0.left.equalToSuperview().offset(16)
//                    $0.right.equalToSuperview().offset(-16)
//                    $0.top.equalTo(self.exchangeView.snp.bottom).offset(40)
//                }
//                self.selectLine.snp.remakeConstraints {
//                    $0.centerX.width.equalTo(self.moneyLb)
//                    $0.centerY.height.equalTo(self.exchangeLineBackView)
//                }
//                count = self.exchangeModel?.exchange_list?.count ?? 0
//
//                self.attentionContentLb.text  = """
//                1.提现申请请在7个工作日左右审批到账；如遇到高峰期，可能延迟到账，请耐心等待。
//                2.满足一定条件才可兑换，且每天最多兑换一次
//                3.具体到账时间按兑换申请后的提示时间为准
//                4.金币兑换成现金的比例会随着平台广告收益浮动
//                """
//                self.exchangeBtn.setTitle("立即提现", for: .normal)
//            } else if (self.exchangeType == 2) {
//                self.moneyLb.textColor = UIColor(hexString: "#7F7F7F")
//                self.moneyLb.font = UIFont.systemFont(ofSize: 16)
//                self.telFeeLb.textColor = UIColor(hexString: "#313131")
//                self.telFeeLb.font = UIFont.systemFont(ofSize: 18)
//                self.exchangeAmountView.snp.remakeConstraints {
//                    $0.left.equalToSuperview().offset(16)
//                    $0.right.equalToSuperview().offset(-16)
//                    $0.top.equalTo(self.exchangeBalanceFeeView.snp.bottom)
//                }
//                self.selectLine.snp.remakeConstraints {
//                    $0.centerX.width.equalTo(self.telFeeLb)
//                    $0.centerY.height.equalTo(self.exchangeLineBackView)
//                }
//                count = self.exchangeModel?.list?.count ?? 0
//
//                self.attentionContentLb.text  = """
//                1.本话费与手机SIM卡话费无关
//                2.仅可在优惠盒子APP使用
//                3.兑换账号必须已注册优惠盒子账号
//                4.兑换完成后可在“我的→消费记录”中查看详情
//                5.兑换后话费及时到账，话费兑换不限次数，不能撤销
//                6.金币兑换成话费的比例会随着平台广告收益浮动
//                """
//                self.exchangeBtn.setTitle("立即兑换", for: .normal)
//            }
//
//            let col = 3
//            let row = count % col > 0 ? count / col + 1 : count / col
//            let cellHeight = 60
//            let height = row * cellHeight + (row - 1) * 6
//
//            self.collectionView?.snp.remakeConstraints {
//                $0.left.right.equalToSuperview()
//                $0.bottom.equalToSuperview()
//                $0.top.equalTo(self.exchangeAmountLb.snp.bottom).offset(15)
//                $0.height.equalTo(height)
//            }
//
//            self.collectionView?.reloadData()
//
//            self.exchangeView.layoutIfNeeded()
//
//            self.containerView.sendSubview(toBack: self.exchangeView)
//        }
//
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//    }
//
//    override func configUI() {
//        super.configUI()
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.edges.equalToSuperview()
        }
        
        setupGoldView()
        
        setupExchangeView()
        
        setupAmountView()
        
        setupAttentionView()
        
        containerView.addSubview(exchangeBtn)
        exchangeBtn.snp.makeConstraints {
            $0.top.equalTo(attentionView.snp.bottom).offset(30)
            $0.height.equalTo(40)
            $0.width.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-47)
        }
        
        // action
        bindTargetActions()
        
        setupAlertView()
        
        setupExchangeBalanceSuccessView()
    }
    
    let exchangeBalanceSuccessView = UIView().then {
        $0.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        $0.isHidden = true
    }
    
    let exchangeBalanceContentLb = UILabel().then {
        $0.textColor = UIColor(hexString: "#505051")
        $0.font = UIFont.systemFont(ofSize: 18)
//        $0.text = "成功兑换"
    }
    
    func setupExchangeBalanceSuccessView() {
        self.view.addSubview(exchangeBalanceSuccessView)
        
        let backView = UIView().then {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            exchangeBalanceSuccessView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(150)
                $0.centerX.equalToSuperview()
                $0.height.equalTo(260)
                $0.left.equalToSuperview().offset(48)
            }
        }
        
        let imgView = UIImageView().then {
            $0.image = UIImage(named: "exchangeTelSuccess.png")
            backView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(40)
                $0.left.equalToSuperview().offset(24)
                $0.height.equalTo(64)
            }
        }
        
        let _ = UILabel().then {
            $0.text = "兑换成功"
            $0.textColor = .white
            $0.font = UIFont.systemFont(ofSize: 18)
            imgView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(15)
            }
        }
        
        backView.addSubview(exchangeBalanceContentLb)
        exchangeBalanceContentLb.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imgView.snp.bottom).offset(43)
        }
        
        let _ = UIButton().then {
            $0.setTitle("知道了", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            $0.backgroundColor = .theme
            $0.layer.cornerRadius = 17
            $0.addTarget(self, action: #selector(onKnowExchangeSuccess), for: .touchUpInside)
            backView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(exchangeBalanceContentLb.snp.bottom).offset(33)
                $0.height.equalTo(34)
                $0.width.equalTo(196)
            }
        }
    }
    
    func setupAlertView() {
        self.navigationItem.title = "提现"
        
        scrollView.backgroundColor = UIColor.white
        updatePageData()
        
        self.view.addSubview(self.bangDingView)
        self.bangDingView.isHidden = true
        self.bangDingView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        bangDingView.clickAction = { [weak self] in
            self?.bangDingView.isHidden = true
            let vc = BangDingViewController()
            vc.titleString = "绑定支付宝"
            vc.mobile = userInfo.user_id ?? ""
            vc.clickAction = { [weak self] (string) in
                //
                self?.xiuGaiView.isHidden = false
                self?.xiuGaiView.labInfo.text = string
            }
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        self.view.addSubview(self.xiuGaiView)
        self.xiuGaiView.isHidden = true
        self.xiuGaiView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        xiuGaiView.clickAction = { [weak self] (type) in
            self?.xiuGaiView.isHidden = true
            
            if type == ZhiFubaoType.tiXian.rawValue {
                ApiLoadingProvider.request(UApi.taskWithdrawMoney(money: (self?.submitMoney)!), model: ExchangeRetModel.self) { [weak self](data, errCode, message, errData) in
                    if errCode == 0 {
                        self?.view?.makeToast("提现申请成功，审核通过后转入你的支付宝账户")
                        // todo: 刷新新数据
                        userInfo.earn_user_info?.coins = (data?.coins)!
                        self?.updatePageData()
                        
                    } else {
                        self?.makeErrorToast(message: message, error: errCode, errData: errData)
                    }
                }
                
            } else if type == ZhiFubaoType.xiuGai.rawValue {
                let vc = BangDingViewController()
                vc.titleString = "修改支付宝"
                vc.mobile = userInfo.user_id ?? ""
                vc.clickAction = { [weak self] (string) in
                    self?.xiuGaiView.isHidden = false
                    self?.xiuGaiView.labInfo.text = string
                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        self.view.addSubview(self.goldBuZuView)
        self.goldBuZuView.isHidden = true
        self.goldBuZuView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        self.goldBuZuView.clickAction = { [weak self] in
            self?.tabBarController?.selectedIndex = taskPageIndex
            self?.navigationController?.popToRootViewController(animated: true)
        }
        // 获取配置信息
        getDataConfig()
    }
    
    
    func bindTargetActions() {
        recordBtn.addTarget(self, action: #selector(exchangeRecord), for: .touchUpInside)
        exchangeBtn.addTarget(self, action: #selector(submitAction(_:)), for: .touchUpInside)
    }
    
    func setupAttentionView() {
        
        containerView.addSubview(attentionView)
        attentionView.snp.makeConstraints {
            $0.left.right.equalTo(exchangeAmountView)
            $0.top.equalTo(exchangeAmountView.snp.bottom).offset(25)
        }
        
        let attentionLb = UILabel().then {
            $0.text = "注意事项"
            attentionView.addSubview($0)
            $0.snp.makeConstraints {
                $0.left.top.equalTo(attentionView)
            }
        }
        
        attentionView.addSubview(attentionContentLb)
        attentionContentLb.snp.makeConstraints {
            $0.left.bottom.right.equalTo(attentionView)
            $0.top.equalTo(attentionLb.snp.bottom).offset(13)
        }
    }
    
    // 兑换现金，话费
    func setupExchangeView() {
        
        containerView.addSubview(exchangeView)
        exchangeView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(goldView.snp.bottom).offset(25)
        }
        
        setupTitleView()
        
        setupExchangeScrollView()

    }
    
    func setupExchangeScrollView() {
        
        exchangeScrollView.delegate = self
        
        exchangeView.addSubview(exchangeScrollView)
        exchangeScrollView.snp.makeConstraints {
            $0.left.bottom.equalToSuperview()
            $0.top.equalTo(selectLine.snp.bottom)
            $0.width.equalTo(screenWidth)
            $0.bottom.equalToSuperview()
        }
        
        setupMoneyView()
        
        setupTelFeeView()
    }
    
    // 兑换现金
    func setupMoneyView() {
        
        exchangeScrollView.addSubview(exchangeMoneyView)
        exchangeMoneyView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.width.equalTo(screenWidth)
            $0.height.equalToSuperview()
        }
        
        let wayView = UILabel().then {
            $0.text = "兑换方式"
            $0.textColor = UIColor(hexString: "#393735")
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            exchangeMoneyView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(35)
                $0.left.equalToSuperview().offset(16)
            }
        }
        
        exchangeMoneyView.addSubview(recordBtn)
        recordBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16)
            $0.centerY.equalTo(wayView)
        }
        
        
        exchangeMoneyView.addSubview(payBackImg)
        payBackImg.snp.makeConstraints {
            $0.left.equalTo(wayView)
            $0.top.equalTo(wayView.snp.bottom).offset(13)
            $0.size.equalTo(CGSize(width: 110, height: 56))
        }
        
        let aliPayImg = UIImageView().then {
            $0.image = UIImage(named: "zhifubao-tupian.png")
            payBackImg.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.width.height.equalTo(25)
            }
        }
        
        let _ = UILabel().then {
            $0.text = "支付宝"
            $0.textColor = .white
            payBackImg.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.equalTo(aliPayImg.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-8)
            }
        }
        
        exchangeMoneyView.addSubview(aliPayStatusLb)
        aliPayStatusLb.snp.makeConstraints {
            $0.left.equalTo(wayView)
            $0.top.equalTo(payBackImg.snp.bottom).offset(15)
        }
        
        exchangeMoneyView.addSubview(bindView)
        bindView.snp.makeConstraints {
            $0.centerY.equalTo(aliPayStatusLb)
            $0.right.equalTo(recordBtn)
            $0.bottom.equalToSuperview()
        }
        
        let rightImg = UIImageView().then {
            $0.image = UIImage(named: "rrh_arrow_right.png")
            bindView.addSubview($0)
            $0.snp.makeConstraints {
                $0.centerY.right.equalToSuperview()
                $0.width.equalTo(10)
            }
        }
        
        bindView.addSubview(bindActionLb)
        bindActionLb.snp.makeConstraints {
            $0.centerY.left.bottom.equalToSuperview()
            $0.right.equalTo(rightImg.snp.left).offset(-10)
        }
        let _ = UITapGestureRecognizer(target: self, action: #selector(onTapBindView)).then {
            bindView.addGestureRecognizer($0)
        }
    }
    
    func setupAmountView() {
        
        containerView.addSubview(exchangeAmountView)
        exchangeAmountView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.top.equalTo(exchangeView.snp.bottom).offset(40)
        }
        
        exchangeAmountView.addSubview(exchangeAmountLb)
        exchangeAmountLb.snp.makeConstraints {
            $0.left.top.equalToSuperview()
        }
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: fl).then {
            $0.backgroundColor = .white
            $0.dataSource = self
            $0.delegate = self
            $0.register(CAGoldCell.self, forCellWithReuseIdentifier: "CAGoldCell")
            
            exchangeAmountView.addSubview($0)
        }
        
    }
    
    // 兑换话费
    func setupTelFeeView() {
        exchangeScrollView.addSubview(exchangeBalanceFeeView)
        exchangeBalanceFeeView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(screenWidth)
            $0.width.equalTo(screenWidth)
        }
        
        exchangeBalanceFeeView.addSubview(exchangeLb)
        exchangeLb.snp.makeConstraints {
            $0.top.equalTo(exchangeLineBackView.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(16)
        }
        
        exchangeBalanceFeeView.addSubview(telFeeTF)
        telFeeTF.snp.makeConstraints {
            $0.centerY.equalTo(exchangeLb)
            $0.left.equalTo(exchangeLb.snp.right).offset(15)
        }
        
        let _ = UIView().then {
            $0.backgroundColor = UIColor(hexString: "#E8E8E8")
            exchangeBalanceFeeView.addSubview($0)
            $0.snp.makeConstraints {
                $0.left.width.equalTo(telFeeTF)
                $0.top.equalTo(telFeeTF.snp.bottom).offset(4)
                $0.height.equalTo(1)
                $0.width.equalTo(150)
                $0.bottom.equalToSuperview().offset(-35)
            }
        }
    }
    
    
    func setupTitleView() {
        exchangeView.addSubview(moneyLb)
        moneyLb.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.height.equalTo(18)
            $0.width.equalTo(75)
        }
        
        exchangeView.addSubview(telFeeLb)
        telFeeLb.snp.makeConstraints {
            $0.left.equalTo(moneyLb.snp.right).offset(20)
            $0.size.centerY.equalTo(moneyLb)
        }

        exchangeView.addSubview(exchangeLineBackView)
        exchangeLineBackView.snp.makeConstraints {
            $0.top.equalTo(moneyLb.snp.bottom).offset(5)
            $0.height.equalTo(2)
            $0.right.equalToSuperview()
            $0.left.equalTo(moneyLb)
        }
        
        exchangeView.addSubview(selectLine)
        selectLine.snp.makeConstraints {
            $0.centerX.width.equalTo(moneyLb)
            $0.centerY.height.equalTo(exchangeLineBackView)
        }
        
        let _ = UITapGestureRecognizer(target: self, action: #selector(onTapExchangeView(tap:))).then {
            moneyLb.addGestureRecognizer($0)
        }
        
        let _ = UITapGestureRecognizer(target: self, action: #selector(onTapExchangeView(tap:))).then {
            telFeeLb.addGestureRecognizer($0)
        }
    }
    
    // 金币
    func setupGoldView() {
        
        containerView.addSubview(goldView)
        goldView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
        
        goldView.addSubview(goldLb)
        goldLb.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalTo(goldView.snp.centerY).offset(-10)
        }
        
        goldView.addSubview(balanceLb)
        balanceLb.snp.makeConstraints {
            $0.left.equalTo(goldLb)
            $0.top.equalTo(goldView.snp.centerY).offset(10)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        goldView.addSubview(expendView)
        expendView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-15)
        }
        
        let expendImg = UIImageView().then {
            $0.image = UIImage(named: "expend.png")
            expendView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.width.height.equalTo(26)
            }
        }
        
        
        let _ = UILabel().then {
            $0.text = "支出明细"
            $0.textColor = UIColor(hexString: "#7F7F7F")
            $0.font = UIFont.systemFont(ofSize: 13)
            expendView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(expendImg.snp.bottom).offset(10)
                $0.centerX.equalTo(expendImg)
                $0.right.left.bottom.equalToSuperview()
            }
        }
        
        goldView.addSubview(incomeView)
        incomeView.snp.makeConstraints {
            $0.top.bottom.equalTo(expendView)
            $0.right.equalTo(expendView.snp.left).offset(-10)
        }
        
        let incomeImg = UIImageView().then {
            $0.image = UIImage(named: "income.png")
            incomeView.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.centerX.equalToSuperview()
                $0.width.height.equalTo(26)
            }
        }
        
        let _ = UILabel().then {
            $0.text = "收入明细"
            $0.textColor = UIColor(hexString: "#7F7F7F")
            $0.font = UIFont.systemFont(ofSize: 13)
            incomeView.addSubview($0)
            $0.snp.makeConstraints {
                $0.bottom.left.right.equalToSuperview()
                $0.top.equalTo(incomeImg.snp.bottom).offset(10)
            }
        }
        
        let _ = UITapGestureRecognizer(target: self, action: #selector(onTapGoldView(tap:))).then {
            expendView.addGestureRecognizer($0)
        }
        
        let _ = UITapGestureRecognizer(target: self, action: #selector(onTapGoldView(tap:))).then {
            incomeView.addGestureRecognizer($0)
        }
    }
    
    
    func updatePageData() -> Void {
        let title = "当前金币: "
        let coin = userInfo.earn_user_info?.coins ?? 0
        let coinStr = String(coin)
        
        let goldMutableAttr = NSMutableAttributedString(string: title + coinStr)
        let goldAttr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 15),.foregroundColor: UIColor(hexString: "#7F7F7F")]
        let coinAttr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 15),.foregroundColor: UIColor(hexString: "#313131")]
        goldMutableAttr.addAttributes(goldAttr, range: NSRange(location: 0, length: title.count))
        goldMutableAttr.addAttributes(coinAttr, range: NSRange(location: title.count, length: coinStr.count))
        
        goldLb.attributedText = goldMutableAttr
        balanceLb.text = "可兑换余额：" + getMoney(coin: coin)
        
        if (userInfo.payee_account?.count ?? 0) > 0 {
            aliPayStatusLb.text = "您已绑定支付宝"
            bindActionLb.text = "立即修改"
        } else {
            aliPayStatusLb.text = "您尚未绑定支付宝"
            bindActionLb.text = "立即绑定"
        }
    }
    
    func getDataConfig() -> Void {
        ApiLoadingProvider.request(UApi.taskWithdrawIndex, model: ExchangeModel.self) { [weak self](data, errCode, message, errData) in
            if errCode == 0 {
                self?.requestExchangeListSuccess(data)
                self?.requestCoinList()
            } else {
                self?.makeErrorToast(message: message, error: errCode, errData: errData)
            }
        }
        
    }
    
    func requestExchangeListSuccess(_ dataLet: ExchangeModel?) {
        var data = dataLet
        userInfo.earn_user_info?.coins = data?.coins ?? 0
        
        if let count = data?.exchange_list?.count, count > 0, let model = data?.exchange_list?[0] {
            data?.exchange_list?[0].isSelect = true
            
            self.exchangeModel = data
            
            self.submitMoney = model.money
            let rate = Double((self.exchangeModel?.exchange_rate ?? 0)/100)
            
            self.realCoins = Int(rate*model.money * model.discount)
            
            self.updatePageData()
            
            if self.exchangeType == 1 {
                let col = 3
                let row = count % col > 0 ? count / col + 1 : count / col
                let cellHeight = 60
                let height = row * cellHeight + (row - 1) * 6
                
                self.collectionView?.snp.makeConstraints {
                    $0.left.right.equalToSuperview()
                    $0.bottom.equalToSuperview()
                    $0.top.equalTo(exchangeAmountLb.snp.bottom).offset(15)
                    $0.height.equalTo(height)
                }
                
                self.collectionView?.reloadData()
            }
            
        }
    }
    
    func requestCoinList() {
        ApiLoadingProvider.request(UApi.goldTobalanceList, model: ExchangeModel.self) { [weak self](dataLet, errCode, message, errData) in
            var data = dataLet
            
            if let count = data?.list?.count, count > 0, let _ = data?.list?[0] {
                data?.list?[0].isSelect = true
                
                self?.exchangeModel?.list = data?.list
                
                if self?.exchangeType == 2 {
                    
                    self?.updateExchangeView(2)
                }
                
            } else {
                self?.view.makeToast("网络连接错误")
            }
        }
    }
    
    @objc func submitAction(_ sender: Any) {
        
        
        if self.exchangeType == 1 {
            // 请求兑换现金
            self.onExchangeMoney()
        } else if self.exchangeType == 2 {
            // 请求兑换话费
            self.onExchangeBalance()
        }
    }
    
    @objc func onKnowExchangeSuccess() {
        
        exchangeBalanceSuccessView.isHidden = true
    }
    
    // 请求兑换现金
    func onExchangeMoney() {
        guard self.submitMoney > 0 else {
            self.view.makeToast("请选择要提现的金额")
            return
        }
        
        if realCoins > (userInfo.earn_user_info?.coins ?? 0) { // 金币不足
            self.goldBuZuView.isHidden = false
            return
        }
        
        // 分享才能兑换
        
        let today = Date.dateFromString(date: Date(), formatter: "yyyy-MM-dd")
        print("today: \(today)")
        
        let date = UserDefaults.standard.string(forKey: String.shareDate)
        if today != date {
            let alert = CACommonAlertView(message: "未完成每日分享任务，完成后即可提现", title: "温馨提示", cancel: "暂不完成", sure: "立即分享")
            alert.clickIndexClosure {[weak self] (index, isSelect) in
                if index == AlertButtonType.Recharge.rawValue {
                    guard let vc = self else { return }
                    CAShareUtils.sharedInstance().shareApp(url: CAQRcode.getInviteUrl(), vc: vc) {
                        NotificationCenter.default.post(name: NSNotification.Name.ShareSuccess, object: self, userInfo: nil)
                    }
                }
                alert.dismiss()
            }
            alert.show()
            return
        }
        
        if (userInfo.payee_account?.count ?? 0) > 0 {
            xiuGaiView.isHidden = false
            self.xiuGaiView.labInfo.text = userInfo.payee_account
        } else {
            bangDingView.isHidden = false
        }
    }
    
    func onExchangeBalance() {
        
        self.telFeeTF.resignFirstResponder()
        
        guard let list = self.exchangeModel?.list, list.count > 0 else {
            self.view.makeToast("暂无可兑换套餐")
            return
        }
        
        guard let mobile = self.telFeeTF.text, CAStringUtils.isTelNumber(mobile) else {
            self.view.makeToast("请输入正确的手机号")
            return
        }
        
        var amount: Double = 0
        var coins = 0
        for item in list {
            if item.isSelect {
                amount = item.money
                coins = item.coins
                break
            }
        }
        
        if coins > (userInfo.earn_user_info?.coins ?? 0) { // 金币不足
            self.goldBuZuView.isHidden = false
            return
        }
        
        ApiLoadingProvider.request(UApi.goldToBalance(mobile: mobile, amount: amount, coins: coins), model: ExchangeRetModel.self) { [weak self](data, errCode, message, errData) in
            if errCode == 0 {
                let title = "成功兑换"
                let money = " \(amount)元 "
                let tel = "话费"
                
                let goldMutableAttr = NSMutableAttributedString(string: title + money + tel)
                let goldAttr: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 25),.foregroundColor: UIColor(hexString: "#ED3030")]
                goldMutableAttr.addAttributes(goldAttr, range: NSRange(location: title.count, length: money.count))
                
                self?.exchangeBalanceContentLb.attributedText = goldMutableAttr
                self?.exchangeBalanceSuccessView.isHidden = false
                // todo: 刷新新数据
                self?.loadMemberInfo({
                    self?.updatePageData()
                })
            } else {
                self?.makeErrorToast(message: message, error: errCode, errData: errData)
            }
        }
    }
}

extension DKUIViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CAGoldCell else { return }
            
        if let exchange_list = self.exchangeModel?.exchange_list, self.exchangeType == 1, let model = self.exchangeModel?.exchange_list?[indexPath.item] {
            if !cell.isCheck {
                
                var arr = exchange_list
                for (i, _) in arr.enumerated() {
                    arr[i].isSelect = false
                }
                
                arr[indexPath.item].isSelect = true
                self.exchangeModel?.exchange_list = arr
                collectionView.reloadData()
                
                submitMoney = model.money
                let rate = Double(self.exchangeModel?.exchange_rate ?? 0)
                realCoins = Int(rate/100*model.money * model.discount)
            }
        } else if let coinList = self.exchangeModel?.list, self.exchangeType == 2{
            if !cell.isCheck {
                var arr = coinList
                for (i, _) in arr.enumerated() {
                    arr[i].isSelect = false
                }
                arr[indexPath.item].isSelect = true
                self.exchangeModel?.list = arr
                collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if self.exchangeType == 1 {
            count = self.exchangeModel?.exchange_list?.count ?? 0
        } else {
            count = self.exchangeModel?.list?.count ?? 0
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CAGoldCell", for: indexPath) as! CAGoldCell
        if let model = self.exchangeModel?.exchange_list?[indexPath.item], self.exchangeType == 1  {
            cell.setData(model, exchange_rate: self.exchangeModel?.exchange_rate ?? 0)
        } else if let model = self.exchangeModel?.list?[indexPath.item], self.exchangeType == 2  {
            cell.setCoinData(model, exchange_rate: self.exchangeModel?.exchange_rate ?? 0)
        }
        return cell
    }
    
}

extension DKUIViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == exchangeScrollView {
            if scrollView.contentOffset.x < screenWidth / 2 {
                UIView.animate(withDuration: 0.5) {
                    self.exchangeAmountView.snp.remakeConstraints {
                        $0.left.equalToSuperview().offset(16)
                        $0.right.equalToSuperview().offset(-16)
                        $0.top.equalTo(self.exchangeView.snp.bottom).offset(40)
                    }
                    self.selectLine.snp.remakeConstraints {
                        $0.centerX.width.equalTo(self.moneyLb)
                        $0.centerY.height.equalTo(self.exchangeLineBackView)
                    }
                    self.exchangeView.layoutIfNeeded()
                }
            }
            containerView.bringSubview(toFront: exchangeView)
        }

    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        var type: Int
        if scrollView == exchangeScrollView {
            if scrollView.contentOffset.x < screenWidth {
                type = 1
                updateExchangeView(type)
            }
            containerView.bringSubview(toFront: exchangeView)
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var type: Int
        if scrollView == exchangeScrollView {
            if scrollView.contentOffset.x < screenWidth {
                type = 1
            } else {
                type = 2
            }
            
            updateExchangeView(type)
        }
    }

}

extension DKUIViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let textLength = text.count + string.count - range.length
        
        if textField.isEqual(telFeeTF){
            return textLength <= 11
        }
        return textLength <= 11
    }
}
