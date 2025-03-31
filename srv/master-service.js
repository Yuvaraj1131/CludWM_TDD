const cds = require('@sap/cds');
const { entity } = require('@sap/cds/lib/core/entities');
module.exports = cds.service.impl(async function () {
    //Entities defination from master and core entity
    const { Units, Materials, MaterialStorageTypes } = this.entities;
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
                req.reject("Materials Storage Types data set is empty. Ensure that units are provided in the correct format before proceeding.");
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
                req.reject("Materials Storage Types data set is empty. Ensure that units are provided in the correct format before proceeding.");
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
})