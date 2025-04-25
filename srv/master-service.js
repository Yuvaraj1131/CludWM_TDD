const cds = require('@sap/cds');
const { entity } = require('@sap/cds/lib/core/entities');
const { message } = require('@sap/cds/lib/log/cds-error');
module.exports = cds.service.impl(async function () {
    //Entities defination from master and core entity
    const { Units, Materials, MaterialStorageTypes, MaterialWarehouses, MaterialUnits, StorageBins, StorageUnits, Warehouses,
        SalesDocuments, SalesDocumentItems, Deliveries, DeliveryItems } = this.entities;
    async function _materialsBatchPost(req) {
        console.log(req);
    }

    /**
     * It handles bulk update/insert of units
     * @param { HTTP Request } req 
     */

    async function _unitsBatchPost(req) {
        try {
            if (req.data?.Units?.length > 0) {
                await _batchUpsert(req.data.Units, Units);
            }
            else {
                req.reject("Units data set is empty. Ensure that units are provided in the correct format before proceeding.");
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
     * @param { HTTP Request } req 
     * It handles bulk update/insert of Materials
     */

    async function _materialsBatchPost(req) {
        try {
            if (req.data?.Materials?.length > 0) {
                await _batchUpsert(req.data.Materials, Materials);
            }
            else {
                req.reject("Materials data set is empty. Ensure that units are provided in the correct format before proceeding.");
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
     * It handles bulk update/insert of materialstoragetypes
     * @param { HTTP Request } req
     * 
     */

    async function _MaterialStorageTypesPost(req) {
        try {
            if (req.data?.MaterialStorageTypes?.length > 0) {
                await _batchUpsert(req.data.MaterialStorageTypes, MaterialStorageTypes);
            }
            else {
                req.reject("Materials Storage Types data set is empty. Ensure that units are provided in the correct format before proceeding.");
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
    * It handles bulk update/insert of MaterialWarehouses
    * @param { HTTP Request } req
    * 
    */

    async function _MaterialWarehousesPost(req) {
        try {
            if (req.data?.MaterialWarehouses?.length > 0) {
                await _batchUpsert(req.data.MaterialWarehouses, MaterialWarehouses);
            }
            else {
                req.reject("Materials Warehouse data set is empty. Ensure that units are provided in the correct format before proceeding.");
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }


    /**
    * It handles bulk update/insert of MaterialUnits
    * @param { HTTP Request } req
    * 
    */

    async function _MaterialUnitsPost(req) {
        try {
            if (req.data?.MaterialUnits?.length > 0) {
                await _batchUpsert(req.data.MaterialUnits, MaterialUnits);
            }
            else {
                req.reject("Material Units data set is empty. Ensure that units are provided in the correct format before proceeding.");
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
     * It handles bulk insert/Update of StorageBins
     * @param {Http req } req 
     */
    async function _StorageBinPost(req) {
        try {
            if (req.data?.StorageBins?.length > 0) {
                await _batchUpsert(req.data.StorageBins, StorageBins);
            }
            else {
                req.reject("Storage Bin data set is empty. Ensure that units are provided in the correct format before proceeding.");
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
     * It handles bulk insert/Update of StorageUnits
     * @param { Http req } req 
     */
    async function _StorageUnitsPost(req) {
        try {
            if (req.data?.StorageUnits?.length > 0) {
                await _batchUpsert(req.data.StorageUnits, StorageUnits);
            }
            else {
                req.reject("Storage Units data set is empty. Ensure that units are provided in the correct format before proceeding.");
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
     * It handles bulk insert/update of Warehouses
     * @param { Http req } req
     */
    async function _WarehousesPost(req) {
        try {
            if (req.data?.Warehouses?.length > 0) {
                await _batchUpsert(req.data.Warehouses, Warehouses);
            }
            else {
                req.reject("Warehouses data set is empty. Ensure that units are provided in the correct format before proceeding.")
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
     * It Handles Bulk Insert/Update of SalesDocuemnt
     * @param { Http req } req
     */

    async function _SalesDocumentsPost(req) {
        try {
            if (req.data?.SalesDocuments?.length > 0) {
                await _batchUpsert(req.data.SalesDocuments, SalesDocuments);
            }
            else {
                req.reject("SalesDocument data is empty. Ensure that Sales Document are provided in the correct format.")
            }
        }
        catch (error) {
            req.reject(error.message);
        }

    }

    /**
    * It Handles Bulk Insert/Update of SalesDocuemntitem
    * @param { Http req } req
    */

    async function _SalesDocumentItemPost(req) {
        try {
            if (req.data?.SalesDocumentItems?.length > 0) {
                await _batchUpsert(req.data.SalesDocumentItems, SalesDocumentItems);
            }
            else {
                req.reject("SalesDocumentItem data is empty. Ensure that Sales Document Item are provided in the correct format.")
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
    * It Handles Bulk Insert/Update of Deliveries
    * @param { Http req } req
    */

    async function _DeliveriesPost(req) {
        try {
            if (req.data?.Deliveries?.length > 0) {
                await _batchUpsert(req.data.Deliveries, Deliveries);
            }
            else {
                req.reject("Deliveries data is empty. Ensure that Deliveries are provided in the correct format.")
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }

    /**
    * It Handles Bulk Insert/Update of DeliveriesItem
    * @param { Http req } req
    */

    async function _DeliveriesItemPost(req) {
        try {
            if (req.data?.DeliveryItems?.length > 0) {
                await _batchUpsert(req.data.DeliveryItems, DeliveryItems);
                req.reply({message: "Delivery Items saved successfully"}, 201);
            }
            else {
                req.reject("Delivery Item data is empty. Ensure that DeliveriesItem are provided in the correct format.")
            }
        }
        catch (error) {
            req.reject(error.message);
        }
    }


    /**
     * Generic function which can handle the update/insert of bulk data
     * @param { Array of Object } data 
     * @param { entity } table 
     */

    async function _batchUpsert(data, table) {
        try {
            await UPSERT.into(table)
                .entries(data);
        }
        catch (error) {
            throw error;
        }
    }

    this.on('materialsBatchPost', _materialsBatchPost.bind(this));
    this.on('unitsBatchPost', _unitsBatchPost.bind(this));
    this.on('MaterialStorageTypesPost', _MaterialStorageTypesPost.bind(this));
    this.on('MaterialWarehousesPost', _MaterialWarehousesPost.bind(this));
    this.on('MaterialUnitsPost', _MaterialUnitsPost.bind(this));
    this.on('StorageBinPost', _StorageBinPost.bind(this));
    this.on('StorageUnitsPost', _StorageUnitsPost.bind(this));
    this.on('WarehousesPost', _WarehousesPost.bind(this));
    this.on('DeliveriesPost', _DeliveriesPost.bind(this));
    this.on('DeliveryItemsPost', _DeliveriesItemPost.bind(this));
    this.on('SalesDocumentsPost', _SalesDocumentsPost.bind(this));
    this.on('SalesDocumentItemPost', _SalesDocumentItemPost.bind(this));
})