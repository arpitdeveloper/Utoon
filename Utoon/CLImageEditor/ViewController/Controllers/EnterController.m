//
//  EnterController.m
//  Utoon
//
//  Created by Macbook Pro on 30/01/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "EnterController.h"
#import "ImageEditController.h"
#import "../_CLImageEditorViewController.h"
#import "CLImageEditor.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface EnterController ()<CLImageEditorDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

{
    UIImagePickerController *picker;
}
@property (strong, nonatomic) IBOutlet UIButton *enterBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageTop;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonBotom;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageRight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *image_Left;

@end

@implementation EnterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //TODO: ---- design ------
    self.enterBtn.layer.cornerRadius = self.enterBtn.bounds.size.height/2;
 
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
   
}

#pragma mark - Button Action


- (IBAction)enterAction:(id)sender {
    
    [self.enterBtn setTitle:@"Upload photo" forState:UIControlStateNormal];
    if ([self.enterBtn.titleLabel.text isEqualToString:@"Upload photo"]) {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.delegate = self;
            
            picker.allowsEditing = YES;
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
            
            [alertController dismissViewControllerAnimated:YES completion:nil];
            [self.enterBtn setTitle:@"Save Image" forState:UIControlStateNormal];
        }];
        [alertController addAction:takePhoto];
        
        UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"From Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
            
            pickerView.allowsEditing = YES;
            
            pickerView.delegate = self;
            
            [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentViewController:pickerView animated:YES completion:nil];
            //[self presentModalViewController:pickerView animated:YES];
            [self.enterBtn setTitle:@"Save Image" forState:UIControlStateNormal];
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertController addAction:choosePhoto];
        
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.enterBtn setTitle:@"Upload photo" forState:UIControlStateNormal];
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertController addAction:actionCancel];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    if ([self.enterBtn.titleLabel.text isEqualToString:@"Save Image"]) {
        
       
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Save Image" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //Handle your yes please button action here
            self.imageView.image = [UIImage imageNamed:@"app_logo"];
            self.imageTop.constant = 50;
            self.image_Left.constant = 30;
            self.imageRight.constant = 30;
            self.buttonBotom.constant = 90;
            self.imageHeight.constant = 315;
            UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
        }];
        UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            //Handle your yes please button action here
            self.imageView.image = [UIImage imageNamed:@"app_logo"];
            self.imageTop.constant = 50;
            self.image_Left.constant = 30;
            self.imageRight.constant = 30;
            self.buttonBotom.constant = 90;
            self.imageHeight.constant = 315;
             [self.enterBtn setTitle:@"Upload photo" forState:UIControlStateNormal];
        }];
        [alert addAction:noButton];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        /*
        NSArray *excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage];
        
        UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[_imageView.image] applicationActivities:nil];
        
        activityView.excludedActivityTypes = excludedActivityTypes;
        activityView.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
            if(completed && [activityType isEqualToString:UIActivityTypeSaveToCameraRoll]){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Saved successfully" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    //Handle your yes please button action here
                    self.imageView.image = [UIImage imageNamed:@"app_logo"];
                    self.imageTop.constant = 50;
                    self.image_Left.constant = 30;
                    self.imageRight.constant = 30;
                    self.buttonBotom.constant = 90;
                    self.imageHeight.constant = 315;
                }];
                [alert addAction:yesButton];
                [self presentViewController:alert animated:YES completion:nil];
            }
        };
        
        [self presentViewController:activityView animated:YES completion:nil];*/
        
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    CLImageToolInfo *tool1 = [editor.toolInfo subToolInfoWithToolName:@"CLAdjustmentTool" recursive:NO];
    CLImageToolInfo *tool2 = [editor.toolInfo subToolInfoWithToolName:@"CLBlurTool" recursive:NO];
    CLImageToolInfo *tool3 = [editor.toolInfo subToolInfoWithToolName:@"CLRotateTool" recursive:NO];
    CLImageToolInfo *tool4 = [editor.toolInfo subToolInfoWithToolName:@"CLToneCurveTool" recursive:NO];
    
    CLImageToolInfo *tool5 = [editor.toolInfo subToolInfoWithToolName:@"CLEffectTool" recursive:NO];
    CLImageToolInfo *tool6 = [editor.toolInfo subToolInfoWithToolName:@"CLFilterTool" recursive:NO];
    CLImageToolInfo *tool7 = [editor.toolInfo subToolInfoWithToolName:@"CLSplashTool" recursive:NO];
    CLImageToolInfo *tool8 = [editor.toolInfo subToolInfoWithToolName:@"CLDrawTool" recursive:NO];
    CLImageToolInfo *tool9 = [editor.toolInfo subToolInfoWithToolName:@"CLResizeTool" recursive:NO];
    CLImageToolInfo *tool10 = [editor.toolInfo subToolInfoWithToolName:@"CLEmoticonTool" recursive:NO];
    CLImageToolInfo *tool11 = [editor.toolInfo subToolInfoWithToolName:@"CLClippingTool" recursive:NO];
    
    tool1.available = NO;
    tool2.available = NO;
    tool3.available = NO;
    tool4.available = NO;
    tool5.available = NO;
    tool6.available = NO;
    tool7.available = NO;
    tool8.available = NO;
    tool9.available = NO;
    tool10.available = NO;
    tool11.available = NO;

    [picker pushViewController:editor animated:YES];
}

#pragma mark - Image Editor ------
- (void)imageEditor:(CLImageEditor *)editor didFinishEditingWithImage:(UIImage *)image
{
    _imageView.image = image;
    [self refreshImageView];
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageEditor:(CLImageEditor *)editor willDismissWithImageView:(UIImageView *)imageView canceled:(BOOL)canceled
{
    [self refreshImageView];
}

- (void)refreshImageView
{
    _imageTop.constant = 10;
    _buttonBotom.constant = 10;
    self.image_Left.constant = 10;
    self.imageRight.constant = 10;
    _imageHeight.constant = self.view.bounds.size.height - 100;
}


@end

