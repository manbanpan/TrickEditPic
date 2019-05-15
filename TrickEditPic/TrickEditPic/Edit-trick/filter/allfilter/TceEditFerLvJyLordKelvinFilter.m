//
//  TceEditFerLvJyLordKelvinFilter.m
//  TceEditFerLvJyMeituApp
//
//  Created by hzkmn on 16/1/8.
//  Copyright © 2016年 ForrestWoo co,.ltd. All rights reserved.
//

NSString *const kTceEditFerLvJyLordKelvinShaderString = SHADER_STRING
(
 precision lowp float;
 
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec3 texel = texture2D(inputImageTexture, textureCoordinate).rgb;
     
     vec2 lookup;
     lookup.y = .5;
     
     lookup.x = texel.r;
     texel.r = texture2D(inputImageTexture2, lookup).r;
     
     lookup.x = texel.g;
     texel.g = texture2D(inputImageTexture2, lookup).g;
     
     lookup.x = texel.b;
     texel.b = texture2D(inputImageTexture2, lookup).b;
     
     gl_FragColor = vec4(texel, 1.0);
 }
 );

#import "TceEditFerLvJyLordKelvinFilter.h"

@implementation TceEditFerLvJyFilter2

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kTceEditFerLvJyLordKelvinShaderString]))
    {
        return nil;
    }
    
    return self;
}

@end

@implementation TceEditFerLvJyLordKelvinFilter

- (id)init
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    UIImage *image = [UIImage imageNamed:@"kelvinMap.png"];
    
    imageSource = [[GPUImagePicture alloc] initWithImage:image];
    TceEditFerLvJyFilter2 *filter = [[TceEditFerLvJyFilter2 alloc] init];
    
    [self addFilter:filter];
    [imageSource addTarget:filter atTextureLocation:1];
    [imageSource processImage];
    
    self.initialFilters = [NSArray arrayWithObjects:filter, nil];
    self.terminalFilter = filter;
    
    return self;
}

@end
