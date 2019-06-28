var insite;
(function (insite) {
    var layout;
    (function (layout) {
        "use strict";
        var LayoutController = (function () {
            function LayoutController($window) {
                this.$window = $window;
                this.init();
            }
            LayoutController.prototype.init = function () {
            };
            LayoutController.prototype.hideHeader = function () {
                return this.$window.insite.hideHeader;
            };
            LayoutController.prototype.hideFooter = function () {
                return this.$window.insite.hideFooter;
            };
            LayoutController.$inject = ["$window"];
            return LayoutController;
        }());
        layout.LayoutController = LayoutController;
        angular
            .module("insite")
            .controller("LayoutController", LayoutController);
    })(layout = insite.layout || (insite.layout = {}));
})(insite || (insite = {}));
//# sourceMappingURL=insite.layout.controller.js.map