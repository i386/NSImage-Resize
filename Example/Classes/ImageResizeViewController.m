//
//  ImageResizeViewController.m
//  UIImageResizeTest
//
//  Created by Olivier on 28/05/10.
//  Copyright 2010 AliSoftware. All rights reserved.
//

#import "ImageResizeViewController.h"
#import "UIImage+Resize.h"

@implementation ImageResizeViewController
@synthesize originalImageView = _originalImageView;
@synthesize scaledImageViewH = _scaledImageViewH;
@synthesize scaledImageViewV = _scaledImageViewV;
@synthesize srcImage = _srcImage;

//////////////////////////////////////////////////////////////////
#pragma mark - IBActions


-(IBAction)pickFromLibrary
{
	UIImagePickerController* ipc = [[UIImagePickerController alloc] init];
	ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	ipc.delegate = self;
	[self presentModalViewController:ipc animated:YES];
	[ipc release];
}

-(IBAction)pickFromCamera
{
	UIImagePickerController* ipc = [[UIImagePickerController alloc] init];
	ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
	ipc.delegate = self;
	[self presentModalViewController:ipc animated:YES];
	[ipc release];	
}
	 
//////////////////////////////////////////////////////////////////
#pragma mark - ImagePicker Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	self.srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	[picker dismissModalViewControllerAnimated:YES];
}

//////////////////////////////////////////////////////////////////
#pragma mark - Refreshing UI

-(void)viewDidAppear:(BOOL)animated
{
	NSLog(@"Updating interface");
	if (!self.srcImage) return;
	
	NSLog(@"Original image (%@): %@",self.srcImage,NSStringFromCGSize(self.srcImage.size));
	self.originalImageView.image = self.srcImage;
	
	UIImage* scaledImgH = [self.srcImage resizedImageToFitInSize:self.scaledImageViewH.bounds.size scaleIfSmaller:NO];
	NSLog(@"Scaled image H (%@): %@",scaledImgH,NSStringFromCGSize(scaledImgH.size));
	self.scaledImageViewH.image = scaledImgH;

	UIImage* scaledImgV = [self.srcImage resizedImageToFitInSize:self.scaledImageViewV.bounds.size scaleIfSmaller:NO];
	NSLog(@"Scaled image V (%@): %@",scaledImgV,NSStringFromCGSize(scaledImgV.size));
	self.scaledImageViewV.image = scaledImgV;
}

//////////////////////////////////////////////////////////////////
#pragma mark - Memory Managment

-(void)viewDidUnload
{
    self.originalImageView = nil;
    self.scaledImageViewH = nil;
    self.scaledImageViewV = nil;
    [super viewDidUnload];
}

-(void)dealloc
{
    [_originalImageView release];
    [_scaledImageViewH release];
    [_scaledImageViewV release];
    [_srcImage release];
    [super dealloc];
}
@end
