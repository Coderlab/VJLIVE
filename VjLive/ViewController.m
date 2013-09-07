//
//  ViewController.m
//  VjLive
//
//  Created by Alessandro Belli on 26/04/13.
//  Copyright (c) 2013 Alessandro Belli. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@end
static void *AVPlayerDemoPlaybackViewControllerStatusObservationContext = &AVPlayerDemoPlaybackViewControllerStatusObservationContext;
@implementation ViewController
@synthesize scalette,su,delegate,chie,sliderDurationSx,sliderDurationDx,segmentedTransizione;
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //setto la variabile per far andare su e giu la vista "musica"
    su=0;
    
    dispatch_queue_t queue = dispatch_queue_create("altro",NULL);
    dispatch_async(queue, ^{
        scalette.tintColor = [UIColor whiteColor];
    });
    mutedx = 0;
    mutesx  = 0;
    loopdx =0;
    loopsx =0;
    chie=0;
    
    //Riconosce lo slide delle dita che muove la vista delle canzoni
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [scalette addGestureRecognizer:panRecognizer];

    //Riconosce il doppio tap per riportare il rate dei video a 1
    UITapGestureRecognizer *tapGesturedx = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesturedx.numberOfTapsRequired = 2;
    [_sliderDx addGestureRecognizer:tapGesturedx];
    
    //Riconosce il doppio tap per riportare il rate dei video a 1'
    UITapGestureRecognizer *tapGesturesx = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesturesx.numberOfTapsRequired = 2;
    [_sliderSx addGestureRecognizer:tapGesturesx];
    
    UITapGestureRecognizer *tapGestureAlpha =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGestureAlpha.numberOfTapsRequired = 2;
    [_alphaChannelSlider addGestureRecognizer:tapGestureAlpha];
    
    UITapGestureRecognizer *tapGestureVolume =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGestureVolume.numberOfTapsRequired = 2;
    [_volumeSliderAvplayer2 addGestureRecognizer:tapGestureVolume];
    
    UITapGestureRecognizer *tapGestureTime =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGestureTime.numberOfTapsRequired = 1;
    [_labelTimeVideoDx addGestureRecognizer:tapGestureTime];
    
    UITapGestureRecognizer *tapGestureTimesx =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGestureTimesx.numberOfTapsRequired = 1;
    [_labelTimeVideoSx addGestureRecognizer:tapGestureTimesx];
    
    
    toccoTimeSx =0;
    toccoTimeDx =0;
    curFrameAlpha = self.checkVC.playerViewsx.frame;
    curFrameAlpha.origin.x = 0;
    ratesx =1.0;
    ratedx =1.0;
    picker2 = [[MPMediaPickerController alloc] init];
    picker= [[MPMediaPickerController alloc] init];
    picker3 = [[MPMediaPickerController alloc] init];
    videoItemSinistra = [[AVPlayerItem alloc]init];
    videoItemDestra = [[AVPlayerItem alloc]init];

}
-(void)viewDidAppear:(BOOL)animated{
    [self controllaseceunoschermo];
    [self setUpScreenConnectionNotificationHandlers];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    
}
-(void)controllaseceunoschermo{
    if ([[UIScreen screens] count] > 1)
    {
        // Get the screen object that represents the external display.
        UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
        // Get the screen's bounds so that you can create a window of the correct size.
        CGRect screenBounds = secondScreen.bounds;
        self.secondWindow = [[UIWindow alloc] initWithFrame:screenBounds];
        self.secondWindow.screen = secondScreen;
        //self.secondWindow.screen.wantsSoftwareDimming = YES;
        
        
        
        self.checkVC.view.frame = screenBounds;
        [self.secondWindow addSubview:self.checkVC.vistaGrande];
        
        self.secondWindow.hidden = NO;
        [self.secondWindow setBackgroundColor:[UIColor blackColor]];
        self.checkVC.view.autoresizesSubviews = NO;
        //[self.secondWindow addSubview:self.checkVC.vistaGrande];
        
        [self.secondWindow makeKeyAndVisible];
        
        
    }

}
-(void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}
- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateRecognized) {
        if (sender.view == _sliderDx){
            _sliderDx.value = 100;
            self.checkVC.playerVideo.rate = _sliderDx.value / 100.0;
            
        }else if (sender.view == _sliderSx){
            _sliderSx.value = 100;
            self.checkVC.playerVideosx.rate = _sliderSx.value / 100.0;
        }else if (sender.view == _alphaChannelSlider){
            _alphaChannelSlider.value =_alphaChannelSlider.maximumValue/2;
            [self cambiaVolumealPlayer];
        }else if(sender.view == _volumeSliderAvplayer2){
            _volumeSliderAvplayer2.value =_volumeSliderAvplayer2.maximumValue/2;
            [self cambiaVolumealPlayer];
        }else if (sender.view == _labelTimeVideoDx){
            
            if(toccoTimeDx==1){
                toccoTimeDx=0;
            }else if (toccoTimeDx==0){
                toccoTimeDx=1;
            }
        
        }else if (sender.view ==_labelTimeVideoSx){
            
            if(toccoTimeSx==1){
                toccoTimeSx=0;
            }else if (toccoTimeSx==0){
                toccoTimeSx=1;
            }
        }
    }
}

-(void)viewWillLayoutSubviews{
    //setta l'opacità al valore dello slider
    
    self.checkVC.playerViewdx.alpha = _alphaChannelSlider.value/ 100.0;
    self.checkVC.playerViewsx.alpha = 1.0 - (_alphaChannelSlider.value/ 100.0);
    
}


- (void)setUpScreenConnectionNotificationHandlers
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(handleScreenDidConnectNotification:)
                   name:UIScreenDidConnectNotification object:nil];
    [center addObserver:self selector:@selector(handleScreenDidDisconnectNotification:)
                   name:UIScreenDidDisconnectNotification object:nil];
}

- (void)handleScreenDidConnectNotification:(NSNotification*)aNotification
{
    if ([[UIScreen screens] count] > 1)
    {
        // Get the screen object that represents the external display.
        UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
        // Get the screen's bounds so that you can create a window of the correct size.
        CGRect screenBounds = secondScreen.bounds;
        self.secondWindow = [[UIWindow alloc] initWithFrame:screenBounds];
        self.secondWindow.screen = secondScreen;
        //self.secondWindow.screen.wantsSoftwareDimming = YES;
        
        
        
        self.checkVC.view.frame = screenBounds;
        [self.secondWindow addSubview:self.checkVC.vistaGrande];
        
        self.secondWindow.hidden = NO;
        [self.secondWindow setBackgroundColor:[UIColor blackColor]];
        self.checkVC.view.autoresizesSubviews = NO;
        //[self.secondWindow addSubview:self.checkVC.vistaGrande];
        
        [self.secondWindow makeKeyAndVisible];
        
        
    }

}

- (void)handleScreenDidDisconnectNotification:(NSNotification*)aNotification
{
    if (self.secondWindow)
    {
        // Hide and then delete the window.
        [[self.secondWindow subviews][0] removeFromSuperview];
        
        self.secondWindow.hidden = YES;
        self.secondWindow = nil;
        self.checkVC.view.frame = CGRectMake(148, 111, 728, 410);
        [self.view addSubview:self.checkVC.view];

        
    }
    
}

- (void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    CGPoint translation = [panRecognizer translationInView:self.view];
    
    CGPoint imageViewPosition = self.scalette.center;
    
    imageViewPosition.y += translation.y;
    if (imageViewPosition.y < 636 ){
        imageViewPosition.y = 636;
    }
    if (imageViewPosition.y > 833 ){
        imageViewPosition.y = 833;
    }
    
    NSLog(@"%f",imageViewPosition.y);
    self.scalette.center = imageViewPosition;
    // muovi la vista canzoni di quanto hai trascinato
    [panRecognizer setTranslation:CGPointZero inView:self.view];
}

-(IBAction)segmentedChanged:(id)sende{
    
    if ([segmentedTransizione selectedSegmentIndex] == 0){
        if ([[UIScreen screens] count] > 1)
        {
            // Get the screen object that represents the external display.
            UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
            // Get the screen's bounds so that you can create a window of the correct size.
            CGRect screenBounds = secondScreen.bounds;
            
            self.checkVC.playerViewsx.frame = screenBounds;
            self.checkVC.playerViewdx.frame = screenBounds;
            if(_alphaChannelSlider.value >51 ){
                nuovomassimodx= [self mappaValori:(_alphaChannelSlider.value/ 100.0) valoremassimocorrente:(_alphaChannelSlider.maximumValue/100) nuovomassimo:100.0f];
                //cambia l'opacità dei video
                self.checkVC.playerViewdx.alpha = nuovomassimodx/ 100.0;
                self.checkVC.playerViewsx.alpha =  1.0-(nuovomassimodx/ 100.0);
            }else if (_alphaChannelSlider.value<51){
                nuovomassimosx = [self mappaValori:(_alphaChannelSlider.value/ 100.0) valoremassimocorrente:(_alphaChannelSlider.maximumValue/100) nuovomassimo:nuovomassimodx];
                self.checkVC.playerViewdx.alpha = nuovomassimosx/ 100.0;
                self.checkVC.playerViewsx.alpha =  1.0-(nuovomassimosx/ 100.0);
            }
            
        }else{
            self.checkVC.playerViewsx.frame = curFrameAlpha;
            self.checkVC.playerViewdx.frame = curFrameAlpha;
            if(_alphaChannelSlider.value >51 ){
                nuovomassimodx= [self mappaValori:(_alphaChannelSlider.value/ 100.0) valoremassimocorrente:(_alphaChannelSlider.maximumValue/100) nuovomassimo:100.0f];
                //cambia l'opacità dei video
                self.checkVC.playerViewdx.alpha = nuovomassimodx/ 100.0;
                self.checkVC.playerViewsx.alpha =  1.0-(nuovomassimodx/ 100.0);
            }else if (_alphaChannelSlider.value<51){
                nuovomassimosx = [self mappaValori:(_alphaChannelSlider.value/ 100.0) valoremassimocorrente:(_alphaChannelSlider.maximumValue/100) nuovomassimo:nuovomassimodx];
                self.checkVC.playerViewdx.alpha = nuovomassimosx/ 100.0;
                self.checkVC.playerViewsx.alpha =  1.0-(nuovomassimosx/ 100.0);
            }
        }
        
        
    }
    else if ([segmentedTransizione selectedSegmentIndex] == 1){
        // sposto la view sinistra a sinistra della view di destra
        self.checkVC.playerViewdx.alpha =1.0;
        self.checkVC.playerViewsx.alpha =1.0;
        if ([[UIScreen screens] count] > 1)
        {
            // Get the screen object that represents the external display.
            UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
            // Get the screen's bounds so that you can create a window of the correct size.
            CGRect screenBounds = secondScreen.bounds;
            float larghezzaschermo = screenBounds.size.width;
            float dove  = [self mappaValori:_alphaChannelSlider.value valoremassimocorrente:0 nuovomassimo:screenBounds.size.width];
            // aggiungere alla cordinata x delle viste il valore di totale-dove
            curFramesx =CGRectMake(-dove, self.checkVC.playerViewsx.frame.origin.y, self.checkVC.playerViewsx.frame.size.width, self.checkVC.playerViewsx.frame.size.height);
            
            
            self.checkVC.playerViewsx.frame = curFramesx;
            
            curFramedx = CGRectMake(larghezzaschermo-dove, self.checkVC.playerViewsx.frame.origin.y, self.checkVC.playerViewsx.frame.size.width, self.checkVC.playerViewsx.frame.size.height);
            self.checkVC.playerViewdx.frame = curFramedx;
        }else{
            float dove  = [self mappaValori:_alphaChannelSlider.value valoremassimocorrente:0 nuovomassimo:self.checkVC.playerViewsx.frame.size.width];
            // aggiungere alla cordinata x delle viste il valore di totale-dove
            
            curFramesx =CGRectMake(-dove, self.checkVC.playerViewsx.frame.origin.y, self.checkVC.playerViewsx.frame.size.width, self.checkVC.playerViewsx.frame.size.height);
            
            
            self.checkVC.playerViewsx.frame = curFramesx;
            
            curFramedx = CGRectMake(self.checkVC.playerViewsx.frame.size.width-dove, self.checkVC.playerViewsx.frame.origin.y, self.checkVC.playerViewsx.frame.size.width, self.checkVC.playerViewsx.frame.size.height);
            self.checkVC.playerViewdx.frame = curFramedx;
        }
        
    }
    
}

-(IBAction)setupMovie
{
    
    if(mutedx ==1){
    
        [self.checkVC.playerViewdx setVolume:0 chi:self.checkVC.playerViewdx.player];

    }else if(mutedx ==0){
        //se è già muto, ritorna al volume dello slider
        [self.checkVC.playerViewdx setVolume:_volumeSliderAvplayer2.value chi:self.checkVC.playerViewdx.player];

    }
    
    if( self.checkVC.playerViewdx.player.rate == 0 && self.checkVC.playerViewdx.player.status == AVPlayerStatusReadyToPlay){
        [_playDx setTitle:@"Pause" forState:UIControlStateNormal];
        
        [self.checkVC.playerViewdx.player play];
        self.checkVC.playerVideo.rate = ratedx;
    }
    else if (self.checkVC.playerViewdx.player.rate != 0){
        [_playDx setTitle:@"Play" forState:UIControlStateNormal];
        [self.checkVC.playerViewdx.player pause];
        
    }
    
}
-(IBAction)setupMovie2
{

    
    if(mutesx ==1){
        [self.checkVC.playerViewsx setVolume:0 chi:self.checkVC.playerViewsx.player];

    }else if(mutesx==0){
        //se è già muto, ritorna al volume dello slider
        [self.checkVC.playerViewsx setVolume:(1-_volumeSliderAvplayer2.value) chi:self.checkVC.playerViewsx.player];

    }
    
    
    if( self.checkVC.playerViewsx.player.rate == 0 && self.checkVC.playerViewsx.player.status == AVPlayerStatusReadyToPlay){
        [_playSx setTitle:@"Pause" forState:UIControlStateNormal];
        [self.checkVC.playerViewsx.player play];
        self.checkVC.playerVideosx.rate = ratesx;
    }
    else if (self.checkVC.playerViewsx.player.rate != 0){
        [_playSx setTitle:@"Play" forState:UIControlStateNormal];
        [self.checkVC.playerViewsx.player pause];
        
    }
}

-(void)listFilesFromDocumentsFolder {
    //---get the path of the Documents folder---
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList =
    [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSMutableString *filesStr =
    [NSMutableString stringWithString:@"Files in Documents folder \n"];
    for (NSString *s in fileList){
        [filesStr appendFormat:@"%@ \n", s];
    }
    
}


-(IBAction)stopMovie{
    
    
    
    if([_playDx.titleLabel.text isEqualToString:@"Pause"]){
        [_playDx setTitle:@"Play" forState:UIControlStateNormal];
    }
    
    [self.checkVC.playerViewdx.player pause];
    [self.checkVC.playerViewdx.player seekToTime:kCMTimeZero];
    
    
}
-(IBAction)stopMovie2{
    
    
    if([_playSx.titleLabel.text isEqualToString:@"Pause"]){
        [_playSx setTitle:@"Play" forState:UIControlStateNormal];
    }
    
    [self.checkVC.playerViewsx.player pause];
    [self.checkVC.playerViewsx.player seekToTime:kCMTimeZero];
    
    
}
- (IBAction)volumeSliderAvplayer2Changed:(UISlider *)volumeSliderAvplayer2
{
    // slider del volume fader, da destra a sinistra
    // il video di destra avrà il valore dello slider, il video di sinistra 1-valore dello slider
    
    //se il pulsante muto è attivo non cambiare volume
    if( mutedx ==1){
    
        
    }else if(mutedx ==0){

        [self.checkVC.playerViewdx setVolume:_volumeSliderAvplayer2.value chi:self.checkVC.playerViewdx.player];
    }
    

    
    //se il pulsante muto è attivo non cambiare volume
    if( mutesx ==1){        
    }else if(mutesx ==0){
        [self.checkVC.playerViewsx setVolume:(1-_volumeSliderAvplayer2.value) chi:self.checkVC.playerViewsx.player];
    }

    
}

- (void)popOverItemSelected:(NSURL *)selectedItem{
    
    if (chie == 0){
        //Video di destra
        
        if([_playDx.titleLabel.text isEqualToString:@"Pause"]){
            [_playDx setTitle:@"Play" forState:UIControlStateNormal];
        }
        videoDestra = [AVAsset assetWithURL:selectedItem];
        
        videoItemDestra = [AVPlayerItem playerItemWithAsset:videoDestra];
        
        if(!self.checkVC.playerVideo){
            self.checkVC.playerVideo = [[AVPlayer alloc]initWithPlayerItem:videoItemDestra];
            
        }else{
            
            [self.checkVC.playerVideo replaceCurrentItemWithPlayerItem:videoItemDestra];
            [self.checkVC.playerVideo pause];
        }
        
        
        [self.checkVC.playerViewdx setMovieToPlayer:self.checkVC.playerVideo];
             
        self.checkVC.playerVideo.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        
        [self setSlider];
    }else if(chie == 1){
        
        
        //Video di sinistra
        videoSinistra = [AVAsset assetWithURL:selectedItem];
        
        videoItemSinistra = [AVPlayerItem playerItemWithAsset:videoSinistra];
        
        if([_playSx.titleLabel.text isEqualToString:@"Pause"]){
            [_playSx setTitle:@"Play" forState:UIControlStateNormal];
        }
        if(!self.checkVC.playerVideosx){
            self.checkVC.playerVideosx = [[AVPlayer alloc]initWithPlayerItem:videoItemSinistra];
            
        }else{

            [self.checkVC.playerVideosx replaceCurrentItemWithPlayerItem:videoItemSinistra];
            [self.checkVC.playerVideosx pause];
        }
        
        [self.checkVC.playerViewsx setMovieToPlayer:self.checkVC.playerVideosx];
        
          self.checkVC.playerVideosx.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        [self setSliderTimeSx];
        
    }
}
-(IBAction)muteVideoSx:(id)sender{
    // rendi muto il video di sinistra

    if(mutesx ==0){
        
        [self.checkVC.playerViewsx setVolume:0 chi:self.checkVC.playerViewsx.player];

        
        mutesx=1;
    }else if(mutesx==1){
        [self.checkVC.playerViewsx setVolume:(1-_volumeSliderAvplayer2.value) chi:self.checkVC.playerViewsx.player];

        mutesx =0;
    }
    
}

-(IBAction)muteVideoDx:(id)sender{
    
    // rendi muto il video di destra
    
    if(mutedx ==0){
        [self.checkVC.playerViewdx setVolume:0 chi:self.checkVC.playerViewdx.player];
        mutedx=1;

        
    }else if(mutedx ==1){
        [self.checkVC.playerViewdx setVolume:_volumeSliderAvplayer2.value chi:self.checkVC.playerViewdx.player];

        mutedx =0;
    }
    
}


- (IBAction)alphaChannelSliderChanged:(UISlider *)alphaChannelSlider{
    
    
    if ([segmentedTransizione selectedSegmentIndex] == 0){
        if(_alphaChannelSlider.value >51 ){
            nuovomassimodx= [self mappaValori:(_alphaChannelSlider.value/ 100.0) valoremassimocorrente:(_alphaChannelSlider.maximumValue/100) nuovomassimo:100.0f];
            //cambia l'opacità dei video
            self.checkVC.playerViewdx.alpha = nuovomassimodx/ 100.0;
            self.checkVC.playerViewsx.alpha =  1.0-(nuovomassimodx/ 100.0);
        }else if (_alphaChannelSlider.value<51){
            nuovomassimosx = [self mappaValori:(_alphaChannelSlider.value/ 100.0) valoremassimocorrente:(_alphaChannelSlider.maximumValue/100) nuovomassimo:nuovomassimodx];
            self.checkVC.playerViewdx.alpha = nuovomassimosx/ 100.0;
            self.checkVC.playerViewsx.alpha =  1.0-(nuovomassimosx/ 100.0);
        }
    }
    else if ([segmentedTransizione selectedSegmentIndex] == 1){
        
        if ([[UIScreen screens] count] > 1)
        {
            // Get the screen object that represents the external display.
            UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
            // Get the screen's bounds so that you can create a window of the correct size.
            CGRect screenBounds = secondScreen.bounds;
            float larghezzaschermo = screenBounds.size.width;
            float dove  = [self mappaValori:_alphaChannelSlider.value valoremassimocorrente:0 nuovomassimo:screenBounds.size.width];
            // aggiungere alla cordinata x delle viste il valore di totale-dove
            curFramesx =CGRectMake(-dove, self.checkVC.playerViewsx.frame.origin.y, self.checkVC.playerViewsx.frame.size.width, self.checkVC.playerViewsx.frame.size.height);
            
            
            self.checkVC.playerViewsx.frame = curFramesx;
            
            curFramedx = CGRectMake(larghezzaschermo-dove, self.checkVC.playerViewsx.frame.origin.y, self.checkVC.playerViewsx.frame.size.width, self.checkVC.playerViewsx.frame.size.height);
            self.checkVC.playerViewdx.frame = curFramedx;
        }else{
            float dove  = [self mappaValori:_alphaChannelSlider.value valoremassimocorrente:0 nuovomassimo:self.checkVC.playerViewsx.frame.size.width];
            // aggiungere alla cordinata x delle viste il valore di totale-dove

            curFramesx =CGRectMake(-dove, self.checkVC.playerViewsx.frame.origin.y, self.checkVC.playerViewsx.frame.size.width, self.checkVC.playerViewsx.frame.size.height);
            
            
            self.checkVC.playerViewsx.frame = curFramesx;
            
            curFramedx = CGRectMake(self.checkVC.playerViewsx.frame.size.width-dove, self.checkVC.playerViewsx.frame.origin.y, self.checkVC.playerViewsx.frame.size.width, self.checkVC.playerViewsx.frame.size.height);
            self.checkVC.playerViewdx.frame = curFramedx;
        }
        
    }
    
    
    
}


-(float)mappaValori:(float)valoreMappare valoremassimocorrente:(float)valoreMassimoCorrente nuovomassimo:(float)NuovoMassimo{
    //serve a non cambiare troppo l'opacità dello slider mappando i valori
    // da 100 a 51 come da 100 a 65
    //e da 51 a 0 come da 65 a 0
    // formula:
    // low2 + (value - low1) * (high2 - low2) / (high1 - low1)
    float valoreMappato = 0.0;
    
    if ([segmentedTransizione selectedSegmentIndex] == 0){
        if(_alphaChannelSlider.value>51){
            valoreMappato = 65+(valoreMappare - 0.51)*(NuovoMassimo-65)/(valoreMassimoCorrente -0.51);
        }
        else if (_alphaChannelSlider.value<51){
            valoreMappato = 0+(valoreMappare -0)*(NuovoMassimo-0)/(valoreMassimoCorrente - 0);
            valoreMappato = valoreMappato*2;
        }
    }
    else if ([segmentedTransizione selectedSegmentIndex] == 1){
        
        valoreMappato = 0 + ( valoreMappare -0)*(NuovoMassimo -0)/(100-0);
        
    }
    
    return valoreMappato;
}

-(void)setSliderTimeSx{
    
    sliderTimerVideoSx = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self    selector:@selector(updateSliderTimeSx) userInfo:nil repeats:YES];
    self.timeSliderSx.maximumValue = [self durationInSecondsSx];
    [_timeSliderSx addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventValueChanged];
    _timeSliderSx.minimumValue = 0.0;
    _timeSliderSx.continuous = YES;
    
}

- (void)updateSliderTimeSx {
    self.timeSliderSx.value = [self currentTimeInSecondsSx];
    NSTimeInterval timeLeft = [self durationInSecondsSx] - [self currentTimeInSecondsSx];
    int min =0;
    int sec =0;
    if (toccoTimeSx==0){
        min = self.timeSliderSx.value/60;
        sec = lroundf(self.timeSliderSx.value)%60;
            _labelTimeVideoSx.text = [NSString stringWithFormat:@"%d:%2.02d", min,sec];
    }else if(toccoTimeSx==1){
        min=timeLeft/60;
        sec = lroundf(timeLeft) % 60;
            _labelTimeVideoSx.text = [NSString stringWithFormat:@"-%d:%2.02d", min,sec];
    }
}

- (Float64)durationInSecondsSx {
    
    Float64 dur = CMTimeGetSeconds([self.checkVC.playerVideosx.currentItem duration]);
    return dur;
}


- (Float64)currentTimeInSecondsSx {
    
    Float64 dur = CMTimeGetSeconds([self.checkVC.playerVideosx currentTime]);
    return dur;
}
-(void)cambiaVolumealPlayer{

    
        //se il pulsante muto è attivo non cambiare volume
        if( mutedx ==1){

            
        }else if(mutedx ==0){
            
            [self.checkVC.playerViewdx setVolume:(_volumeSliderAvplayer2.value) chi:self.checkVC.playerViewdx.player];
            
        }
    
        
               
        //se il pulsante muto è attivo non cambiare volume
        if( mutesx ==1){
            
        }else if(mutesx ==0){
            [self.checkVC.playerViewsx setVolume:(1-_volumeSliderAvplayer2.value) chi:self.checkVC.playerViewsx.player];
        }
        
    
}
-(void)sliding:(id)sender{
    
    if([sender isEqual:_timeSliderDx]){
        
        
        if( [_playDx.titleLabel.text isEqual:@"Pause"]){
            [self.checkVC.playerVideo pause];
            
        }
        
        CMTime newTime = CMTimeMakeWithSeconds(_timeSliderDx.value, 1);
        dispatch_queue_t queue = dispatch_queue_create("cambiatempo",NULL);

        dispatch_async(queue, ^{
            
            CMTime t1 = CMTimeMake(1, 5);
            [self.checkVC.playerVideo seekToTime:newTime toleranceBefore: t1 toleranceAfter: t1];
        });
        
        [self cambiaVolumealPlayer];
        if( [_playDx.titleLabel.text isEqual:@"Pause"]){
            [self.checkVC.playerVideo setRate:ratedx] ;
        }
;
    }else if ([sender isEqual:_timeSliderSx]){
        
        
        if( [_playSx.titleLabel.text isEqual:@"Pause"]){
            [self.checkVC.playerVideosx pause];
            
        }
        CMTime newTime = CMTimeMakeWithSeconds(_timeSliderSx.value, 1);
        dispatch_queue_t queue = dispatch_queue_create("cambiatempo2",NULL);
        dispatch_async(queue, ^{
            
            CMTime t1 = CMTimeMake(1, 5);
            [self.checkVC.playerVideosx seekToTime:newTime toleranceBefore:t1 toleranceAfter:t1];
        });
        
        [self cambiaVolumealPlayer];
        if( [_playSx.titleLabel.text isEqual:@"Pause"]){
        [self.checkVC.playerVideosx setRate:ratesx];            
        }

    }else{
        NSLog(@"%@",sender);
    }

}
-(void)setSlider{
    
    sliderTimerVideo = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self    selector:@selector(updateSliderTime) userInfo:nil repeats:YES];
    self.timeSliderDx.maximumValue = [self durationInSeconds];
    [_timeSliderDx addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventValueChanged];
    _timeSliderDx.minimumValue = 0.0;
    _timeSliderDx.continuous = YES;
    
}

- (void)updateSliderTime {
    self.timeSliderDx.value = [self currentTimeInSeconds];
    NSTimeInterval timeLeft = [self durationInSeconds] - [self currentTimeInSeconds];
    int min =0;
    int sec =0;
    if (toccoTimeDx==0){
        min = self.timeSliderDx.value/60;
        sec = lroundf(self.timeSliderDx.value)%60;
            _labelTimeVideoDx.text = [NSString stringWithFormat:@"%d:%2.02d", min,sec];
    }else if(toccoTimeDx==1){
        min=timeLeft/60;
        sec = lroundf(timeLeft) % 60;
            _labelTimeVideoDx.text = [NSString stringWithFormat:@"-%d:%2.02d", min,sec];
    }
}

- (Float64)durationInSeconds {
    
    Float64 dur = CMTimeGetSeconds([self.checkVC.playerVideo.currentItem duration]);
    return dur;
}


- (Float64)currentTimeInSeconds {
    
    Float64 dur = CMTimeGetSeconds([self.checkVC.playerVideo currentTime]);
    return dur;
}
- (void)playerItemDidReachEnd:(NSNotification *)notification {
    
    
    AVPlayerItem *p = [notification object];
    if(p ==  videoItemDestra){
        [self.checkVC.playerVideo pause];
        
        
        if(mutedx ==1){
            [self.checkVC.playerViewdx setVolume:0 chi:self.checkVC.playerViewdx.player];
        }else{
            //se è già muto, ritorna al volume dello slider
            [self.checkVC.playerViewdx setVolume:_volumeSliderAvplayer2.value chi:self.checkVC.playerViewdx.player];
        }
        [self.checkVC.playerVideo setRate:ratedx];
    }else if (p == videoItemSinistra){
        [self.checkVC.playerVideosx pause];
        
        if(mutesx ==1){
            [self.checkVC.playerViewsx setVolume:0 chi:self.checkVC.playerViewsx.player];
            
        }else{
           
            [self.checkVC.playerViewsx setVolume:(1-_volumeSliderAvplayer2.value) chi:self.checkVC.playerViewsx.player];
}
        
        [self.checkVC.playerVideosx setRate:ratesx];
    }
    [p seekToTime:kCMTimeZero];
    
}

- (IBAction)playerItemmmDidReachEnd {
    
    //setto il loop del video di destra
    if (loopdx ==0){
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[self.checkVC.playerVideo currentItem]];
        loopdx = 1;
    }else{
        //se c'è già, lo tolgo
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.checkVC.playerVideo currentItem]];
        loopdx = 0;
    }
}

- (IBAction)playerItemmDidReachEnd {
    
    //setto il loop del video di sinistra
    if (loopsx ==0){
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[self.checkVC.playerVideosx currentItem]];
        loopsx = 1;
    }else{
        //se c'è già, lo tolgo
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.checkVC.playerVideosx currentItem]];
        loopsx = 0;
    }
}
- (IBAction)sliderRateVideo:(UISlider *)sliderSx{
    
    ratesx = _sliderSx.value / 100.0;
    if( [_playSx.titleLabel.text isEqual:@"Pause"]){
        self.checkVC.playerVideosx.rate = ratesx;
    }
    
}
- (IBAction)sliderRateVideodx:(UISlider *)sliderDx{
    
    ratedx = _sliderDx.value/100;
    if( [_playDx.titleLabel.text isEqual:@"Pause"]){
        self.checkVC.playerVideo.rate = ratedx;
    }
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"popover"] || [[segue identifier] isEqualToString:@"popover3"]  )
    {
        self.popSegue = (UIStoryboardPopoverSegue*)segue;
        [[segue destinationViewController] setDelegate:self];
        chie =0;
    }
    if ([[segue identifier] isEqualToString:@"popover2"] || [[segue identifier] isEqualToString:@"popover4"] )
    {
        
        
        self.popSegue = (UIStoryboardPopoverSegue*)segue;

        [[segue destinationViewController] setDelegate:self];
        chie =1;
    }
    
    if ([segue.identifier isEqualToString:@"cpdc_check_embed"]) {
        self.checkVC = segue.destinationViewController;
        segui = segue.destinationViewController;
    }
}


- (IBAction)sliderValueChanged:(UISlider *)slidersx {
    
    // slider del cambio del volume del deck musicale di sinistra
    player.volume = _slidersx.value / 100.0;
}
- (IBAction)sliderValueChangeddx:(UISlider *)sliderdx{
    
    player2.volume = _sliderdx.value / 100.0;
}
// slider del cambio del volume del deck musicale di destra
- (IBAction)showMediaPicker:(id)sender
{
    
    // Crea una media picker view
    picker.delegate = self;
    [picker setAllowsPickingMultipleItems: NO];
    picker.prompt =
    NSLocalizedString (@"AGGIUNGI UNA CANZONE AL DECK DI DESTRA",
                       "Prompt in media item picker");
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        
        // Falla vedere in un popover
        popover = [[UIPopoverController alloc] initWithContentViewController:picker];
        
        if (self.view.window != nil){
            if (su==1) {
                [popover presentPopoverFromRect:CGRectMake(_bottone2.frame.origin.x-120, _bottone2.frame.origin.y-30+_bottone2.frame.size.height, 300, 200) inView:scalette permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                NSLog(@"%f e %f",_bottone2.frame.origin.x, _bottone2.frame.origin.y);
            }else{
                [popover presentPopoverFromRect:CGRectMake(_bottone2.frame.origin.x-150+(_bottone2.frame.size.width/2), _bottone2.frame.origin.y, 300, 200) inView:scalette permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                NSLog(@"%f e %f",_bottone2.frame.origin.x, _bottone2.frame.origin.y);
            }
        }
        
        
    } else {
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
    
}
- (IBAction)showMediaPicker2:(id)sender
{
    
    //Crea una media picker view
    picker2.delegate = self;
    [picker2 setAllowsPickingMultipleItems: NO];
    picker2.prompt =
    NSLocalizedString (@"AGGIUNGI UNA CANZONE AL DECK DI SINISTRA",
                       "Prompt in media item picker");
    picker2.title = @"TITOLOSX";
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        
        // Falla vedere in un popover
        popover2 = [[UIPopoverController alloc] initWithContentViewController:picker2];
        
        if (self.view.window != nil){
            if (su==1) {
                [popover2 presentPopoverFromRect:CGRectMake(_bottone.frame.origin.x-150-_bottone.frame.size.width-_bottone.frame.size.width, _bottone.frame.origin.y-123+_bottone.frame.size.height, 300, 200) inView:scalette permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                NSLog(@"%f e %f",_bottone.frame.origin.x, _bottone.frame.origin.y);
            }else{
                [popover2 presentPopoverFromRect:CGRectMake(_bottone.frame.origin.x-150+(_bottone.frame.size.width/2), _bottone.frame.origin.y, 300, 200) inView:scalette permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                NSLog(@"%f e %f",_bottone.frame.origin.x, _bottone.frame.origin.y);
            }
        }
        
        
    } else {
        
        [self presentViewController:picker2 animated:YES completion:nil];
        
    }
    
}
- (IBAction)showMediaPicker3:(id)sender
{
    
    
    MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInteger:MPMediaTypeAnyVideo] forProperty:MPMediaItemPropertyMediaType];
    
    MPMediaQuery *query = [[MPMediaQuery alloc] init];
    [query addFilterPredicate:predicate];
    
    
}



- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    
    [popover dismissPopoverAnimated:YES];
    [popover2 dismissPopoverAnimated:YES];
    [popover3 dismissPopoverAnimated:YES];
    [picker dismissMoviePlayerViewControllerAnimated];
    [picker2 dismissMoviePlayerViewControllerAnimated];
    // il media picker ha un massimo di 1 elemento selezionabile
    //quindi creato l'array degli elementi selezionati per forza quello che ci interessa sarà primo posto
    MPMediaItem *item = [[mediaItemCollection items] objectAtIndex:0];
    
    MPMediaItemArtwork *artWork = [item valueForProperty:MPMediaItemPropertyArtwork];
    if ([mediaPicker.title isEqualToString:@"TITOLOSX"]){
        urlSongSinistra = [item valueForProperty:MPMediaItemPropertyAssetURL];
        
        
        [player stop];
        _cover1.image = [artWork imageWithSize:CGSizeMake(96, 96)];
        _titolo1.text = [item valueForProperty:MPMediaItemPropertyTitle];
        
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlSongSinistra error:nil];
        [player prepareToPlay];
        
        // Setto un timer che ogni 0.5 secondi aggiorna lo slider del tempo
        sliderTimerSx = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
        
        // Setto il massimo dello slider al massimo della durata della canzone
        sliderDurationSx.maximumValue = player.duration;
        
        // controllo se cambia canzone rifaccio il controllo sulla durata
        
        [sliderDurationSx addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        [popover dismissPopoverAnimated:YES];
        
        /*
         dispatch_queue_t queue = dispatch_queue_create("createWaveForm",NULL);
         dispatch_async(queue, ^{
         waveFormImage = [waveFormImage initWithUrl:urlSongSinistra];
         
         });
         */
    }else{
        
        urlSongDestra = [item valueForProperty:MPMediaItemPropertyAssetURL];
        player2 = nil;
        [player2 stop];
        _cover2.image = [artWork imageWithSize:CGSizeMake(96, 96)];
        _titolo2.text = [item valueForProperty:MPMediaItemPropertyTitle];
        
        
        player2 = [[AVAudioPlayer alloc]initWithContentsOfURL:urlSongDestra error:nil];
        [player2 prepareToPlay];
        // Set a timer which keep getting the current music time and update the UISlider in 1 sec interval
        sliderTimerDx = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
        // Set the maximum value of the UISlider
        sliderDurationDx.maximumValue = player2.duration;
        // Set the valueChanged target
        [sliderDurationDx addTarget:self action:@selector(sliderDxChanged:) forControlEvents:UIControlEventValueChanged];
        [popover dismissPopoverAnimated:YES];
        
        /*
         dispatch_queue_t queue = dispatch_queue_create("createWaveForm",NULL);
         dispatch_async(queue, ^{
         _WaveformImageViewDx = [waveFormImage initWithUrl:urlSongDestra];
         });
         */
    }
    
    
}

- (void)updateSlider {
	// Aggiorna gli slider del tempo dei deck musicali
	sliderDurationSx.value = player.currentTime;
    sliderDurationDx.value = player2.currentTime;
    
}
- (IBAction)sliderChanged:(UISlider *)sender {
    
	// Se un utente va avanti sulla linea temporale re-imposta il tempo sul secondo in cui è settato lo slider
    if ( player.isPlaying ){
        [player stop];
        [player setCurrentTime:sliderDurationSx.value];
        [player prepareToPlay];
        [player play];
    }else{
        [player stop];
        [player setCurrentTime:sliderDurationSx.value];
        [player prepareToPlay];
    }
    
}
- (IBAction)sliderDxChanged:(UISlider *)sender {
    
	// Se un utente va avanti sulla linea temporale re-imposta il tempo sul secondo in cui è settato lo slider
    if ( player2.isPlaying ){
    	[player2 stop];
        [player2 setCurrentTime:sliderDurationDx.value];
        [player2 prepareToPlay];
        [player2 play];
    }else{
        [player2 stop];
        [player2 setCurrentTime:sliderDurationDx.value];
        [player2 prepareToPlay];
    }
    
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    // se clicchi cancel il popover sparisce
    [popover dismissPopoverAnimated:YES];
}
- (IBAction)showHideView:(id)sender
{
    if(su==0){
        [UIView animateWithDuration:0.1f
                              delay:0.0f
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [scalette setFrame:CGRectMake(0.0f, 526.0f, scalette.frame.size.width, scalette.frame.size.height)];
                         }
                         completion:nil];
        
        su=1;
        
    }else{
        [UIView animateWithDuration:0.1f
                              delay:0.0f
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [scalette setFrame:CGRectMake(0.0f,722.0f , scalette.frame.size.width, scalette.frame.size.height)];
                         }
                         completion:nil];
        
        
        su = 0;
    }
    
}
-(IBAction)stopCanzonesx:(id)sender{
    
    //stoppa la canzone
    [player stop];
    player.currentTime = 0;
    
}
-(IBAction)stopCanzonedx:(id)sender{
    
    //stoppa la canzone
    [player2 stop];
    player2.currentTime = 0;
    
}
-(IBAction)pausaPlayCanzoneSelezionatasx{
    
    
    // pausa e play del player audio
    if(player.playing){
        
        [player pause];
    }else if(!player.playing){
        [self sliderValueChangeddx:_sliderdx];
        [player play];
        
    }
}



-(IBAction)pausaPlayCanzoneSelezionatadx{
    
    // pausa e play del player audio
    if(player2.playing){
        
        [player2 pause];
    }else if(!player2.playing){
        [self sliderValueChanged:_slidersx];
        [player2 play];
        
    }
    
}

@end
