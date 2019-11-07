//
//  ImageEditController.m
//  Utoon
//
//  Created by Macbook Pro on 30/01/19.
//  Copyright © 2019 Rajesh Shinde. All rights reserved.
//

#import "ImageEditController.h"
#import "CLImageEditor.h"

@interface ImageEditController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLImageEditorDelegate>
{
    UIImagePickerController *picker;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UIButton *addTextBtn;

@property (strong, nonatomic) IBOutlet UIButton *galleryBtn;
@property (strong, nonatomic) IBOutlet UIButton *cameraBtn;

@property (strong, nonatomic) IBOutlet UITextField *textTF;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@end

@implementation ImageEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //TODO: ---- design ------
    _galleryBtn.layer.cornerRadius = _galleryBtn.bounds.size.height/2;
    _cameraBtn.layer.cornerRadius = _cameraBtn.bounds.size.height/2;
    _saveBtn.layer.cornerRadius = _saveBtn.bounds.size.height/2;
    _addTextBtn.layer.cornerRadius = _addTextBtn.bounds.size.height/2;
    
    //TODO: ---- show & hide ------
    [self.imageview setHidden:YES];
    [self.cameraBtn setHidden:YES];
    [self.saveBtn setHidden:YES];
    [self.addTextBtn setHidden:YES];
    [self.textTF setHidden:YES];
    
}

#pragma mark - Button Action

- (IBAction)galleryAction:(id)sender {
    
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)cameraAction:(id)sender {

}

- (IBAction)saveAction:(id)sender {
    //UIImageWriteToSavedPhotosAlbum(_imageview.image, nil, nil, nil);
}
- (IBAction)addTextAction:(id)sender {
   
    
}

#pragma mark - Image View Methods


//////////////////////////////////

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
@end
