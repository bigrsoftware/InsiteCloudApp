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
        var UploadError = insite.common.UploadError;
        var UploadToListPopupController = (function (_super) {
            __extends(UploadToListPopupController, _super);
            function UploadToListPopupController($rootScope, $scope, productService, wishListService, coreService, uploadToListPopupService, settingsService) {
                var _this = this;
                _super.call(this, $scope, productService, coreService, settingsService);
                this.$rootScope = $rootScope;
                this.$scope = $scope;
                this.productService = productService;
                this.wishListService = wishListService;
                this.coreService = coreService;
                this.uploadToListPopupService = uploadToListPopupService;
                this.settingsService = settingsService;
                this.uploadToListPopupService.registerDisplayFunction(function (list) {
                    _this.cleanupUploadData();
                    _this.badFile = false;
                    _this.uploadLimitExceeded = false;
                    _this.list = list;
                    _this.coreService.displayModal(angular.element("#popup-upload-list"));
                });
            }
            UploadToListPopupController.prototype.uploadProducts = function (popupSelector) {
                var _this = this;
                _super.prototype.uploadProducts.call(this, popupSelector);
                this.wishListService.addWishListLines(this.list, this.products).then(function (lineCollection) { _this.uploadingCompleted(lineCollection); }, function (error) { _this.uploadingFailed(error); });
            };
            UploadToListPopupController.prototype.validateProduct = function (product) {
                if (product.canConfigure || (product.isConfigured && !product.isFixedConfiguration)) {
                    return UploadError.ConfigurableProduct;
                }
                if (product.isStyleProductParent) {
                    return UploadError.StyledProduct;
                }
                return UploadError.None;
            };
            UploadToListPopupController.prototype.uploadingCompleted = function (data) {
                _super.prototype.uploadingCompleted.call(this, data);
                this.$rootScope.$broadcast("UploadingItemsToListCompleted");
            };
            UploadToListPopupController.prototype.showUploadingPopup = function () {
                this.coreService.displayModal(angular.element("#listUploadingPopup"));
            };
            UploadToListPopupController.prototype.hideUploadingPopup = function () {
                this.coreService.closeModal("#listUploadingPopup");
            };
            UploadToListPopupController.prototype.showUploadSuccessPopup = function () {
                this.coreService.displayModal(angular.element("#listUploadSuccessPopup"));
            };
            UploadToListPopupController.prototype.hideUploadSuccessPopup = function () {
                this.cleanupUploadData();
                this.coreService.closeModal("#listUploadSuccessPopup");
            };
            UploadToListPopupController.prototype.showUploadingIssuesPopup = function () {
                this.coreService.displayModal(angular.element("#listUploadingIssuesPopup"));
            };
            UploadToListPopupController.prototype.hideUploadingIssuesPopup = function () {
                this.coreService.closeModal("#listUploadingIssuesPopup");
            };
            UploadToListPopupController.$inject = ["$rootScope", "$scope", "productService", "wishListService", "coreService", "uploadToListPopupService", "settingsService"];
            return UploadToListPopupController;
        }(insite.common.BaseUploadController));
        wishlist.UploadToListPopupController = UploadToListPopupController;
        var UploadToListPopupService = (function (_super) {
            __extends(UploadToListPopupService, _super);
            function UploadToListPopupService() {
                _super.apply(this, arguments);
            }
            UploadToListPopupService.prototype.getDirectiveHtml = function () {
                return "<isc-upload-to-list-popup></isc-upload-to-list-popup>";
            };
            return UploadToListPopupService;
        }(base.BasePopupService));
        wishlist.UploadToListPopupService = UploadToListPopupService;
        angular
            .module("insite")
            .controller("UploadToListPopupController", UploadToListPopupController)
            .service("uploadToListPopupService", UploadToListPopupService)
            .directive("iscUploadToListPopup", function () { return ({
            restrict: "E",
            replace: true,
            templateUrl: "/PartialViews/List-UploadToListPopup",
            controller: "UploadToListPopupController",
            controllerAs: "vm",
            bindToController: true
        }); });
    })(wishlist = insite.wishlist || (insite.wishlist = {}));
})(insite || (insite = {}));
//# sourceMappingURL=insite.upload-to-list-popup.controller.js.map