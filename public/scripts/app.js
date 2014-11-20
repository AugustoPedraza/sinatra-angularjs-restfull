var EcommerceApp = angular.module('EcommerceApp', ['ngRoute']);

EcommerceApp.config(['$routeProvider', function($routeProvider) {
  $routeProvider.
    when('/signup', {
      templateUrl: 'scripts/templates/saludar.html',
      controller: 'SaludarController'
    }).
    when('/', {
      templateUrl: 'scripts/templates/welcome.html',
      controller: 'WelcomeController'
    }).
    otherwise({
      redirectTo: '/'
    });
}]);

EcommerceApp.controller('SaludarController', ['$scope', function($scope) {
  $scope.message = 'Hello world!';
}]);

EcommerceApp.controller('WelcomeController', ['$scope', function($scope) {
  $scope.message = 'Get all your favourites products with craziest prices.';
}]);
