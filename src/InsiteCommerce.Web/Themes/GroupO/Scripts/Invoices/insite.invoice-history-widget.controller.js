var insite;
(function (insite) {
    var invoice;
    (function (invoice) {
        "use strict";
        var InvoiceHistoryWidgetController = (function () {
            function InvoiceHistoryWidgetController(invoiceService, coreService, settingsService) {
                this.invoiceService = invoiceService;
                this.coreService = coreService;
                this.settingsService = settingsService;
                this.init();
            }
            InvoiceHistoryWidgetController.prototype.init = function () {
                var _this = this;
                this.settingsService.getSettings().then(function (settingsCollection) { _this.getSettingsCompleted(settingsCollection); }, function (error) { _this.getSettingsFailed(error); });
            };
            InvoiceHistoryWidgetController.prototype.getSettingsCompleted = function (settingsCollection) {
                this.showInvoices = settingsCollection.invoiceSettings.showInvoices;
                if (this.showInvoices) {
                    this.getInvoices();
                }
            };
            InvoiceHistoryWidgetController.prototype.getSettingsFailed = function (error) {
            };
            InvoiceHistoryWidgetController.prototype.getInvoices = function () {
                var _this = this;
                var searchFilter = {
                    customerSequence: "-1",
                    sort: "InvoiceDate DESC",
                    fromDate: ""
                };
                var pagination = {
                    page: 1,
                    pageSize: 5
                };
                this.invoiceService.getInvoices(searchFilter, pagination).then(function (invoiceCollection) { _this.getInvoicesCompleted(invoiceCollection); }, function (error) { _this.getInvoicesFailed(error); });
            };
            InvoiceHistoryWidgetController.prototype.getInvoicesCompleted = function (invoiceCollection) {
                this.invoiceHistory = invoiceCollection;
            };
            InvoiceHistoryWidgetController.prototype.getInvoicesFailed = function (error) {
            };
            InvoiceHistoryWidgetController.prototype.showShareModal = function (entityId) {
                this.coreService.displayModal("#shareEntityPopupContainer_" + entityId);
            };
            InvoiceHistoryWidgetController.$inject = ["invoiceService", "coreService", "settingsService"];
            return InvoiceHistoryWidgetController;
        }());
        invoice.InvoiceHistoryWidgetController = InvoiceHistoryWidgetController;
        angular
            .module("insite")
            .controller("InvoiceHistoryWidgetController", InvoiceHistoryWidgetController);
    })(invoice = insite.invoice || (insite.invoice = {}));
})(insite || (insite = {}));
//# sourceMappingURL=insite.invoice-history-widget.controller.js.map