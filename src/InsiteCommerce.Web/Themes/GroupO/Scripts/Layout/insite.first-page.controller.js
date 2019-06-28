var insite;
(function (insite) {
    var layout;
    (function (layout) {
        "use strict";
        var FirstPageController = (function () {
            function FirstPageController($scope, $rootScope) {
                this.$scope = $scope;
                this.$rootScope = $rootScope;
                this.init();
            }
            FirstPageController.prototype.init = function () {
                var _this = this;
                // properly destroy and remove first page content
                var removeListener = this.$rootScope.$on("$stateChangeStart", function () {
                    _this.$scope.$destroy();
                    angular.element("#firstPageContainer").remove();
                    removeListener();
                });
            };
            FirstPageController.$inject = ["$scope", "$rootScope"];
            return FirstPageController;
        }());
        layout.FirstPageController = FirstPageController;
        angular
            .module("insite")
            .controller("FirstPageController", FirstPageController);
    })(layout = insite.layout || (insite.layout = {}));
})(insite || (insite = {}));
//# sourceMappingURL=insite.first-page.controller.js.map