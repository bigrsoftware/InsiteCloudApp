var insite;
(function (insite) {
    var brands;
    (function (brands) {
        "use strict";
        var VisitBrandWebsiteController = (function () {
            function VisitBrandWebsiteController($window, brandService) {
                this.$window = $window;
                this.brandService = brandService;
                this.init();
            }
            VisitBrandWebsiteController.prototype.init = function () {
                var _this = this;
                this.brandService.getBrandByPath(this.$window.location.pathname).then(function (brand) { _this.getBrandByPathCompleted(brand); }, function (error) { _this.getBrandByPathFailed(error); });
            };
            VisitBrandWebsiteController.prototype.getBrandByPathCompleted = function (brand) {
                this.externalUrl = brand.externalUrl;
            };
            VisitBrandWebsiteController.prototype.getBrandByPathFailed = function (error) {
            };
            VisitBrandWebsiteController.$inject = ["$window", "brandService"];
            return VisitBrandWebsiteController;
        }());
        brands.VisitBrandWebsiteController = VisitBrandWebsiteController;
        angular
            .module("insite")
            .controller("VisitBrandWebsiteController", VisitBrandWebsiteController);
    })(brands = insite.brands || (insite.brands = {}));
})(insite || (insite = {}));
//# sourceMappingURL=insite.visit-brand-website.controller.js.map