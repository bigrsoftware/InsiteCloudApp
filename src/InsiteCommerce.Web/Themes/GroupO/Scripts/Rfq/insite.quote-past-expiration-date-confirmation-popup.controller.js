var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var insite;
(function (insite) {
    var rfq;
    (function (rfq) {
        "use strict";
        var QuotePastExpirationDatePopupController = (function () {
            function QuotePastExpirationDatePopupController($rootScope, coreService, quotePastExpirationDatePopupService) {
                this.$rootScope = $rootScope;
                this.coreService = coreService;
                this.quotePastExpirationDatePopupService = quotePastExpirationDatePopupService;
                this.init();
            }
            QuotePastExpirationDatePopupController.prototype.init = function () {
                var _this = this;
                this.quotePastExpirationDatePopupService.registerDisplayFunction(function (data) {
                    _this.url = data.url;
                    setTimeout(function () {
                        _this.coreService.displayModal(angular.element("#popup-quote-past-expiration-date"));
                    });
                });
            };
            QuotePastExpirationDatePopupController.prototype.cancel = function () {
                this.coreService.closeModal("#popup-quote-past-expiration-date");
            };
            QuotePastExpirationDatePopupController.prototype.submitQuote = function () {
                this.$rootScope.$broadcast("submitQuote", this.url);
                this.coreService.closeModal("#popup-quote-past-expiration-date");
            };
            QuotePastExpirationDatePopupController.$inject = [
                "$rootScope",
                "coreService",
                "quotePastExpirationDatePopupService"];
            return QuotePastExpirationDatePopupController;
        }());
        rfq.QuotePastExpirationDatePopupController = QuotePastExpirationDatePopupController;
        var QuotePastExpirationDatePopupService = (function (_super) {
            __extends(QuotePastExpirationDatePopupService, _super);
            function QuotePastExpirationDatePopupService() {
                _super.apply(this, arguments);
            }
            QuotePastExpirationDatePopupService.prototype.getDirectiveHtml = function () {
                return "<isc-quote-past-expiration-date-popup></isc-quote-past-expiration-date-popup>";
            };
            return QuotePastExpirationDatePopupService;
        }(base.BasePopupService));
        rfq.QuotePastExpirationDatePopupService = QuotePastExpirationDatePopupService;
        angular
            .module("insite")
            .controller("QuotePastExpirationDatePopupController", QuotePastExpirationDatePopupController)
            .service("quotePastExpirationDatePopupService", QuotePastExpirationDatePopupService)
            .directive("iscQuotePastExpirationDatePopup", function () { return ({
            restrict: "E",
            replace: true,
            scope: {
                popupId: "@"
            },
            templateUrl: "/PartialViews/Rfq-QuotePastExpirationDatePopup",
            controller: "QuotePastExpirationDatePopupController",
            controllerAs: "vm",
            bindToController: true
        }); });
    })(rfq = insite.rfq || (insite.rfq = {}));
})(insite || (insite = {}));
//# sourceMappingURL=insite.quote-past-expiration-date-confirmation-popup.controller.js.map