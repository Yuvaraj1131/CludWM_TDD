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
    action materialsBatchPost(Materials : array of Materials)                             returns String;
    action unitsBatchPost(Units : array of Units)                                         returns String;
    action MaterialStorageTypesPost(MaterialStorageTypes : array of MaterialStorageTypes) returns String;
    action MaterialWarehousesPost(MaterialWarehouses : array of MaterialWarehouses)       returns String;
    action MaterialUnitsPost(MaterialUnits : array of MaterialUnits)                      returns String;
    action StorageBinPost(StorageBins : array of StorageBins)                             returns String;
    action StorageUnitsPost(StorageUnits : array of StorageUnits)                         returns String;
    action WarehousesPost(Warehouses : array of Warehouses)                               returns String;
    action SalesDocumentsPost(SalesDocuments : array of SalesDocuments)                   returns String;
    action SalesDocumentItemPost(SalesDocumentItems : array of SalesDocumentItems)        returns String;
    action DeliveriesPost(Deliveries : array of Deliveries)                               returns String;
    action DeliveryItemsPost(DeliveryItems : array of DeliveryItems)                      returns String;
}
