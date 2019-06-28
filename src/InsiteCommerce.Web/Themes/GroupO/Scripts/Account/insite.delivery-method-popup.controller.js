var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var insite;
(function (insite) {
    var account;
    (function (account) {
        "use strict";
        var DeliveryMethodPopupController = (function () {
            function DeliveryMethodPopupController(coreService, deliveryMethodPopupService) {
                this.coreService = coreService;
                this.deliveryMethodPopupService = deliveryMethodPopupService;
                this.init();
            }
            DeliveryMethodPopupController.prototype.init = function () {
                var _this = this;
                this.deliveryMethodPopupService.registerDisplayFunction(function (data) {
                    _this.session = data.session;
                    _this.fulfillmentMethod = data.session.fulfillmentMethod;
                    _this.pickUpWarehouse = data.session.pickUpWarehouse;
                    _this.coreService.displayModal(angular.element("#deliveryMethodPopup"));
                });
            };
            DeliveryMethodPopupController.$inject = ["coreService", "deliveryMethodPopupService"];
            return DeliveryMethodPopupController;
        }());
        account.DeliveryMethodPopupController = DeliveryMethodPopupController;
        var DeliveryMethodPopupService = (function (_super) {
            __extends(DeliveryMethodPopupService, _super);
            function DeliveryMethodPopupService() {
                _super.apply(this, arguments);
            }
            DeliveryMethodPopupService.prototype.getDirectiveHtml = function () {
                return "<isc-delivery-method-popup></isc-delivery-method-popup>";
            };
            return DeliveryMethodPopupService;
        }(base.BasePopupService));
        account.DeliveryMethodPopupService = DeliveryMethodPopupService;
        angular
            .module("insite")
            .controller("DeliveryMethodPopupController", DeliveryMethodPopupController)
            .service("deliveryMethodPopupService", DeliveryMethodPopupService)
            .directive("iscDeliveryMethodPopup", function () { return ({
            restrict: "E",
            replace: true,
            templateUrl: "/PartialViews/Account-DeliveryMethodPopup",
            controller: "DeliveryMethodPopupController",
            controllerAs: "vm",
            bindToController: true
        }); });
    })(account = insite.account || (insite.account = {}));
})(insite || (insite = {}));
//# sourceMappingURL=insite.delivery-method-popup.controller.js.map