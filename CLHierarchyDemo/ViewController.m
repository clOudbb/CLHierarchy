//
//  ViewController.m
//  CLHierarchyDemo
//
//  Created by 张征鸿 on 2021/3/31.
//

#import <Masonry.h>
#import <CLHierarchy/CLHierarchy.h>

#import "ViewController.h"

#import "ViewHierarchyFormatter.h"
#import "CLHierarchyExtendManager.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()

@end

@implementation ViewController {
    UIView *_container1;
    UIView *_container2;
    UIView *_view1;
    UIView *_view2;
    UIView *_view3;
    
    UIViewController *_controller1;
    UIViewController *_controller2;
    
    CLViewHierarchyManager *_manager;
    ViewHierarchyFormatter *_formatter;
}

- (UIView *)_factory:(UIColor *)color superview:(UIView *)superview {
    return ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = color;
        view;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _container1 = [self _factory:UIColor.grayColor superview:self.view];
    _container2 = [self _factory:UIColor.systemPinkColor superview:self.view];
    
    _view1 = [self _factory:UIColor.orangeColor superview:_container1];
    _view2 = [self _factory:UIColor.blueColor superview:_container1];
    _view3 = [self _factory:UIColor.purpleColor superview:_container1];
    
#pragma mark - manager
    _formatter = [[ViewHierarchyFormatter alloc] init];
    _manager = [[CLViewHierarchyManager alloc] initWithRootView:self.view];
//    [_manager.pluginManager install:_formatter];
    _manager.requireConsoleLog = YES;
    
    // CL_ADD_VIEW_HIERARCHY = [_manager add]
    CL_ADD_VIEW_HIERARCHY(_manager, {
        make.view(_container1).superview(self.view).level(5);
        make.identify(@"container1");
    })
    
//    [_manager add:^(CLViewHierarchyNodeMaker * _Nonnull make) {
//        make.view(_container1).superview(self.view).level(5);
//        make.identify(@"container1");
//    }];
    
    [_manager add:^(CLViewHierarchyNodeMaker * _Nonnull make) {
        make.view(_view1).superview(_container1).level(-100);
        make.identify(@"view1");
    }];
    
    [_manager add:^(CLViewHierarchyNodeMaker * _Nonnull make) {
        make.view(_view2).superview(_container1).level(200);
        make.identify(@"view2");
    }];
    
    [_manager add:^(CLViewHierarchyNodeMaker * _Nonnull make) {
        make.view(_view3).superview(_container1).level(30);
        make.identify(@"view3");
    }];
    
    // container 2
    [_manager add:^(CLViewHierarchyNodeMaker * _Nonnull make) {
        make.view(_container2).superview(self.view).level(10);
        make.identify(@"_container2");
    }];

    
    for (int i = 0; i < 10; i++) {
        UIView *v = [[UIView alloc] init];
        [_manager add:^(CLViewHierarchyNodeMaker * _Nonnull make) {
            CLHierarchyLevel level = i * 5.0;
            make.view(v).superview(_container2).identify([NSString stringWithFormat:@"_container2_view %.f", level]).level(level);
        }];

        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.inset(5 + i);
        }];
        v.backgroundColor = randomColor;
    }
    
    [_container1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.view).multipliedBy(0.5);
    }];
    
    [_container2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.view).multipliedBy(0.5);
    }];
    
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(50);
    }];
    
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(60);
    }];
    
    [_view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(70);
    }];
    
    
    
    
    // controller
    
//    _controller1 = [[UIViewController alloc] init];
//    _controller1.view.backgroundColor = UIColor.systemPinkColor;
//    [_manager add:^(CLViewHierarchyNodeMaker * _Nonnull make) {
//        make.view(_controller1.view).superview(self.view).level(100);
//    }];
//    [_controller1 didMoveToParentViewController:self];
    
}

@end
