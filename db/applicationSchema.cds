namespace cloud.wm.application;

using {
  managed,
  cuid
} from '@sap/cds/common';

using {
  cloud.wm.core.Units,
  cloud.wm.core.Warehouses,
  cloud.wm.core.DeliveryItems,
  cloud.wm.core.Materials
} from './schema';

entity PickTaskStatuses {
  key ID          : String(10);
      Description : localized String(100);
}

entity PickTypes {
  key ID          : String(15);
      Description : localized String(100);
}

entity Media {
  key ID          : String(10);
      description : localized String(30);
}

entity MediaTypes : cuid {
  Plant                    : String(4);
  Temperature              : String(12);
  Media                    : Association to Media;
  NoOfPosition             : Int16;
  PositionCubicCapacity    : Decimal(15, 3);
  CapacityUtilisation      : Decimal(15, 3);
  SingleItemMaxWeight      : Decimal(15, 3);
  MaximumWeightCage        : Decimal(15, 3);
  MaximumWeightMono        : Decimal(15, 3);
  MaximumWeightMulti       : Decimal(15, 3);
  MonoCubeMin              : Decimal(15, 3);
  MonoCubeMax              : Decimal(15, 3);
  MonoCubeThreshold        : Decimal(15, 3);
  MultiCubeMin             : Decimal(15, 3);
  MultiCubeMax             : Decimal(15, 3);
  MultiCubeThreshold       : Decimal(15, 3);
  CustomerPerPositionSweep : Int16;
  CustomerPerPositionPick  : Int16;
  SheetingNoOfCustomers    : Int16;
}

entity StorageLocationMerging {
  key Temperature : String(12);
  key Plant       : String(8);
  key Sloc        : String(8);
}

entity MHETypes {
  key ID               : String(10);
      Description      : localized String(40);
      HandlingCapacity : Int32;
}

entity MHEAssignments : cuid {
  Plant       : String(4);
  Temperature : String(12);
  MheType     : Association to MHETypes;
}

entity ShortReasonCodes {
  key Code        : String(5);
      Description : localized String(15);
}

entity MarshallingStatuses {
  key ID          : String(10);
      Description : localized String(40);
}

entity Groups {
  key ID          : String(10);
      Description : String(50);
      To_Areas    : Association to many Areas
                      on To_Areas.Group = $self;
}

entity Areas {
  key ID                 : String(10);
  key Group              : Association to Groups;
      Description        : localized String(50);
      To_MarshallingBins : Association to many MarshallingBins
                             on To_MarshallingBins.Area = $self;
}

entity MarshallingBinStatuses {
  key ID          : String(10);
      Description : localized String(50);
}

entity MarshallingBins {
  key ID                : String(10);
  key Area              : Association to Areas;
      Description       : String(50);
      Capacity          : Decimal(15, 3);
      CapacityUsed      : Decimal(15, 3);
      CapacityAvailable : Decimal(15, 3);
      Plant             : String(4);
      Temperature       : String(12);
      Status            : Association to MarshallingBinStatuses;
      IsBlocked         : Boolean;
}

entity MarshallingRules : cuid {
  Plant                        : String(4);
  Temperature                  : String(12);
  MediaType                    : Association to MediaTypes;
  PickStatus                   : Association to PickTaskStatuses;
  Route                        : String(10);
  CurrentMarshallingAreaID     : Association to Areas;
  DestinationMarshallingAreaID : Association to Areas;

}

entity PalletisationStatuses {
  key ID          : String(10);
      Description : localized String(40);
}

entity PickTaskHeaders : managed {
  key ID                     : String(20);
      PickType               : Association to PickTypes;
      MediaType              : Association to MediaTypes;
      CageID                 : String(20);
      PalletID               : String(20);
      Plant                  : String(10);
      Route                  : String(10);
      TotalCube              : Decimal(20, 3);
      Status                 : Association to PickTaskStatuses;
      MediaPlacement         : String(2);
      DeliveryDate           : Date;
      MHEType                : Association to MHEAssignments;
      PickerUserID           : String(20);
      NominalWeight          : Decimal(20, 3);
      PickJob                : String(10);
      NoOfPackingBoxRequired : Int16;
      Temperature            : String(12);
      To_PickTaskItems       : Association to many PickTaskItems
                                 on To_PickTaskItems.Task = $self;
}

entity PickTaskItems {
  key Task                  : Association to PickTaskHeaders;
  key ItemID                : String(16);
      Material              : Association to Materials;
      TotalQuantity         : Decimal(15, 3);
      OpenQuantity          : Decimal(15, 3);
      Uom                   : Association to Units;
      PositionInCage        : String(2);
      ShipTo                : String(15);
      Cube                  : Decimal(15, 3);
      Status                : Association to PickTaskStatuses;
      Drop                  : Int32;
      PickStickLabelID      : String(30);
      OriginalPickTask      : Association to PickTaskItems;
      FinalPalletID         : String(20);
      Batch                 : String(10);
      SLoc                  : String(4);
      Warehouse             : Association to Warehouses;
      SourceStorageBin      : String(10);
      SourceStorageType     : String(3);
      NominalWeight         : Decimal(20, 3);
      ActualWeight          : Decimal(20, 3);
      ReplenID              : UUID;
      IsReplenCompleted     : Boolean;
      PalletisedQuantity    : Decimal(15, 3);
      PickSequence          : Integer;
      PackingBoxRequired    : Boolean;
      ShortReasonCode       : Association to ShortReasonCodes;
      To_PickTaskDeliveries : Association to many PickTaskDeliveries
                                on To_PickTaskDeliveries.PickTask = $self;
      To_Palletisations     : Association to many PalletisationItems
                                on To_Palletisations.Task = $self;
}

entity PickTaskDeliveries : cuid {
  PickTask      : Association to PickTaskItems;
  DeliveryItems : Association to DeliveryItems;
}

entity Marshalling : cuid {
  Task             : Association to PickTaskHeaders;
  CageID           : String(20);
  palletID         : String(20);
  Status           : Association to MarshallingStatuses;
  Route            : String(10);
  LastDrop         : Int32;
  VehicleID        : String(15);
  Plant            : String(4);
  Temperature      : String(12);
  MarshallingBinID : Association to MarshallingBins;
  IsWrapped        : Boolean;
}

entity PalletisationHeaders : cuid {
  Route                : String(10);
  TotalCube            : Decimal(15, 3);
  PalletID             : String(20);
  Status               : Association to PalletisationStatuses;
  To_PalletisationItem : Association to many PalletisationItems
                           on To_PalletisationItem.palletisation = $self;
}

entity PalletisationItems : cuid {
  key palletisation  : Association to PalletisationHeaders;
      PositionInCage : String(2);
      Material       : Association to Materials;
      LabelID        : String(50);
      Quantity       : Decimal(15, 3);
      Uom            : Association to Units;
      Status         : Association to PalletisationStatuses;
      Drop           : Int32;
      Cube           : Decimal(15, 3);
      CageID         : String(20);
      Task           : Association to PickTaskItems;
      //MarshallingID varchar [ref: > Marshalling.ID]
      OpenQuantity   : Decimal(15, 3);
}

entity PlantRoutes {
  key Plant               : String(4);
  key Route               : String(10);
      Priority            : Integer;
      PlannedDepatureTime : Timestamp;
}

entity MediaDeterminations {
  key Plant           : String(4);
  key Temperature     : String(12);
  key PickType        : Association to PickTypes;
  key Route           : String(10);
      OutputMediaType : Association to MediaTypes;
}

entity RouteVechicleMappings {
  key Route      : String(10);
  key Plant      : String(4);
  key VechicleID : String(15);
}

entity RemovalStrategyHeaders : cuid {
  Plant     : String(4);
  SLoc      : String(4);
  Warehouse : Association to Warehouses;
  PickType  : Association to PickTypes;
}

entity RemovalStrategyItems {
  key Sequence    : Integer;
      Strategy    : Association to RemovalStrategyHeaders;
      StorageType : String(3);
}

entity PickWalkSequence {
  key WarehouseNumber : Association to Warehouses;
  key StorageType     : String(3);
  key StorageBin      : String(10);
      Sequence        : Integer;
}

entity ReplenRuleHeaders : cuid {
  Warehouse          : Association to Warehouses;
  StorageType        : String(3);
  Priority           : Integer;
  To_ReplenRuleItems : Association to many ReplenRuleItems
                         on To_ReplenRuleItems.ReplenRule = $self;
}

entity ReplenRuleItems : cuid {
  ReplenRule : Association to ReplenRuleHeaders;
  RH         : String(20);
  Expression : String(8);
  LH         : String(20);
  Condition  : String(10)
}

entity MaterialPackings {
  key Material                  : Association to Materials;
      IsPackingBoxRequired      : Boolean;
      WeightTolarencePercentage : Int16;
      WeightStopPercentage      : Int16;
}

/*entity MonoPalletCubeLimit {
  key Plant         : String(4);
  key Temperature   : String(12);
  key Route         : String(10);
      MonoMAX       : Decimal(15, 3);
      MonoMIN       : Decimal(15, 3);
      MonoThreshold : Decimal(15, 3);
}*/

entity PackingBox {
  key PackBoxType   : String(10);
      CubicCapacity : Decimal(15, 3);
}

entity DataSync : managed {
  key Object            : String(10);
      Region            : String(5);
      LastSuccessfulRun : DateTime;
}

entity DataSyncLog : cuid, managed {
  Object       : Association to DataSync;
  LogText      : String;
  SyncDateUsed : DateTime;
  Status       : String(10);
}
