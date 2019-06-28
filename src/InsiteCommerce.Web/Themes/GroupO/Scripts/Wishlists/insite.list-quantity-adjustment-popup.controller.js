var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var insite;
(function (insite) {
    var wishlist;
    (function (wishlist) {
        "use strict";
        var ListQuantityAdjustmentPopupController = (function () {
            function ListQuantityAdjustmentPopupController(coreService, listQuantityAdjustmentPopupService) {
                this.coreService = coreService;
                this.listQuantityAdjustmentPopupService = listQuantityAdjustmentPopupService;
                this.init();
            }
            ListQuantityAdjustmentPopupController.prototype.init = function () {
                this.registerDisplayFunction();
            };
            ListQuantityAdjustmentPopupController.prototype.registerDisplayFunction = function () {
                var _this = this;
                this.listQuantityAdjustmentPopupService.registerDisplayFunction(function (data) { return _this.displayFunction(data); });
            };
            ListQuantityAdjustmentPopupController.prototype.displayFunction = function (data) {
                var _this = this;
                this.isQtyAdjusted = false;
                if (data && data.isQtyAdjusted) {
                    this.isQtyAdjusted = data.isQtyAdjusted;
                }
                var showPopup = this.isQtyAdjusted;
                if (!showPopup) {
                    return;
                }
                var popupSelector = ".list-quantity-adjustment-popup";
                var $popup = angular.element(popupSelector);
                if ($popup.length <= 0) {
                    return;
                }
                this.coreService.displayModal($popup);
                if (!this.isQtyAdjusted) {
                    setTimeout(function () {
                        _this.coreService.closeModal(popupSelector);
                    }, 3000);
                }
            };
            ListQuantityAdjustmentPopupController.$inject = [
                "coreService",
                "listQuantityAdjustmentPopupService"
            ];
            return ListQuantityAdjustmentPopupController;
        }());
        wishlist.ListQuantityAdjustmentPopupController = ListQuantityAdjustmentPopupController;
        var ListQuantityAdjustmentPopupService = (function (_super) {
            __extends(ListQuantityAdjustmentPopupService, _super);
            function ListQuantityAdjustmentPopupService() {
                _super.apply(this, arguments);
            }
            ListQuantityAdjustmentPopupService.prototype.getDirectiveHtml = function () {
                return "<isc-list-quantity-adjustment-popup></isc-quantity-adjustment-popup>";
            };
            return ListQuantityAdjustmentPopupService;
        }(base.BasePopupService));
        wishlist.ListQuantityAdjustmentPopupService = ListQuantityAdjustmentPopupService;
        angular
            .module("insite")
            .controller("ListQuantityAdjustmentPopupController", ListQuantityAdjustmentPopupController)
            .service("listQuantityAdjustmentPopupService", ListQuantityAdjustmentPopupService)
            .directive("iscListQuantityAdjustmentPopup", function () { return ({
            restrict: "E",
            replace: true,
            templateUrl: "/PartialViews/List-ListQuantityAdjustmentPopup",
            controller: "ListQuantityAdjustmentPopupController",
            controllerAs: "vm",
            scope: {},
            bindToController: true
        }); });
    })(wishlist = insite.wishlist || (insite.wishlist = {}));
})(insite || (insite = {}));
//# sourceMappingURL=insite.list-quantity-adjustment-popup.controller.js.map