using cloud.wm.core as wm from '../db/schema';

@path: '/CloudWM'
service CloudWMService {
    entity Materials            as projection on wm.Materials;
    entity Units                as projection on wm.Units;
    entity MaterialStorageTypes as projection on wm.MaterialStorageTypes;
    entity MaterialWarehouses   as projection on wm.MaterialWarehouses;
    entity MaterialUnits        as projection on wm.MaterialUnits;
    entity Warehouses           as projection on wm.Warehouses;
    entity quants               as projection on wm.Quants;
    entity StorageBins          as projection on wm.StorageBins;
    entity StorageUnits         as projection on wm.StorageUnits;
    entity SalesDocuments       as projection on wm.SalesDocuments;
    entity SalesDocumentItems   as projection on wm.SalesDocumentItems;
    entity Deliveries           as projection on wm.Deliveries;
    entity DeliveryItems        as projection on wm.DeliveryItems;
    entity MaterialStorageLocation as projection on wm.MaterialStorageLocation;
}
