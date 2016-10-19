//
//  PharmacyVO.h
//  BenefitBridge
//
//  Created by Infinitum on 04/08/16.
//  Copyright © 2016 Infinitum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PharmacyVO : NSObject
@property(nonatomic,retain) NSString *PharmacyID,*Name,*Address1,*Address2,*City,*State,*Zip,*Distance,*PharmacyPhone,*Latitude,*Longitude,*Chain,*ChainName;
@property(nonatomic,readwrite)BOOL Has24hrServiceBool,HasCompoundingBool,HasDeliveryBool,HasDriveupBool,HasDurableEquipmentBool,HasEPrescriptionsBool,HasHandicapAccessBool,IsHomeInfusionBool,IsLongTermCareBool;

@end
