//
//  ZJDetailViewController.m
//  ZJCustomViewControllerTransition
//
//  Created by Zhu J on 11/4/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJDetailViewController.h"
#import "ZJToViewController.h"
#import "ZJTransitionDelegateObj.h"
@interface ZJDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) ZJTransitionDelegateObj *transitionObj;
- (void)configureView;
@end

@implementation ZJDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    ZJTransitionDelegateObj *transion = [[ZJTransitionDelegateObj alloc] init];
    self.transitionObj = transion;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
- (IBAction)presentAction:(id)sender
{
    ZJToViewController *toVC = [[ZJToViewController alloc] initWithNibName:nil bundle:nil];
    
    toVC.transitioningDelegate = self.transitionObj;
    toVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:toVC animated:YES completion:nil];
}
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


@end
