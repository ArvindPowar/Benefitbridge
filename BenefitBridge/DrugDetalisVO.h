//
//  DrugDetalisVO.h
//  BenefitBridge
//
//  Created by Infinitum on 22/09/16.
//  Copyright © 2016 KEENAN & ASSOCIATES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrugDetalisVO : NSObject
@property(nonatomic,retain) NSString *UserID,*LoginID,*SubscriberCode,*DosageID,*ReferenceNDC,*LabelName,*CommonUserQuantity,*CommonMetricQuantity,*CommonDaysOfSupply,*IsCommonDosage,*PackageDescription,*PackageSize,*PackageSizeUnitOfMeasure,*PackageQuantity,*TotalPackageQuantity,*GenericDosageID;

@end
