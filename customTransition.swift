class customTransition: UIPresentationController {
    
    class Animation: NSObject {
    }
    
    var overlayView = UIView()
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        overlayView.frame = containerView.bounds
        overlayView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(overlayViewDidTouch(_:)))]
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.0
        containerView.insertSubview(overlayView, at: 0)
        
        // トランジションを実行
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] context in
            self?.overlayView.alpha = 0.3
            }, completion:nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] context in
            self?.overlayView.alpha = 0.0
            }, completion:nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            overlayView.removeFromSuperview()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height * 0.7)
    }
    
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect()
        let containerBounds = containerView!.bounds
        let childContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.size = childContentSize
        presentedViewFrame.origin.y = containerBounds.size.height * 0.3
        
        return presentedViewFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        overlayView.frame = containerView!.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.clipsToBounds = true
    }
    
    override func containerViewDidLayoutSubviews() {
    }
    
    @objc func overlayViewDidTouch(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

extension customTransition.Animation: UIViewControllerAnimatedTransitioning {
    
    private var duration: TimeInterval {
        return 0.3
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let isPresenting = transitionContext.view(forKey: .from) == nil
        guard let target = isPresenting ?
            transitionContext.viewController(forKey: .to)?.view :
            transitionContext.viewController(forKey: .from)?.view
            else {
                return
        }
        
        let animation: () -> ()
        
        if isPresenting {
            
            transitionContext.containerView.addSubview(target)
            
//            target.frame.origin.x = -target.frame.width
            target.frame.origin.y = target.frame.height
            
            animation = {
                
//                target.frame.origin.x = 0
                target.frame.origin.y = target.frame.height * 0.3
            }
            
        } else {
//            animation = { target.frame.origin.x = -target.frame.width }
            animation = { target.frame.origin.y = (transitionContext.viewController(forKey: .to)?.view.frame.height)! }
        }
        
        UIView.animate(withDuration: duration, animations: animation) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
}
