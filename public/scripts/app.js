var EcommerceApp = angular.module('EcommerceApp', ['ngRoute', 'ngResource']);

EcommerceApp.factory('SessionInjector', ["$window", "$location", "$q", function($window, $location, $q) {
  return {
    request: function(config) {
      var token = $window.sessionStorage.token;
      config.headers['Authorization'] = token && token !== "undefined" ? token : '';

      return config;
    },
    requestError: function(config) {
      return config;
    },
    responseError: function(response) {
      if (response.status == 401) {
        alert("You need to be logged.");
        $location.path("/");
      }

      if(response.status == 422) {
        return $q.reject(response);
      }

      return response;
    }
  };
}]);

EcommerceApp.config(['$routeProvider', '$httpProvider', function($routeProvider, $httpProvider) {
  $routeProvider.
    when('/signup', {
      templateUrl: 'scripts/templates/signup.html',
      controller: 'UsersController'
    }).
    when('/signin', {
      templateUrl: 'scripts/templates/signin.html',
      controller: 'UsersController'
    }).
    when('/', {
      templateUrl: 'scripts/templates/welcome.html',
      controller: 'WelcomeController'
    }).
    when('/products', {
      templateUrl: 'scripts/templates/products.html',
      controller: 'ProductsController'
    }).
    otherwise({
      redirectTo: '/'
    });

  $httpProvider.interceptors.push('SessionInjector');
}]);

EcommerceApp.run(['$http', '$window', function($http, $window) {
  $http.defaults.headers.common.Authorization = $window.sessionStorage.token;
}]);

EcommerceApp.factory('User', ['$resource', function($resource) {
  return $resource('/api/users/:id');
}]);

EcommerceApp.factory('Session', ['$resource', function($resource) {
  return $resource('/api/sessions/:id');
}]);

EcommerceApp.factory('Product', ['$resource', function($resource) {
  return $resource('/api/products/:id');
}]);

EcommerceApp.controller('UsersController', ['$scope', 'User', 'Session', '$window', '$location', function($scope, User, Session, $window, $location) {
  $scope.message = 'Hello world!';

  $scope.signup = function(form) {
    var user = new User();
    user.username               = form.username;
    user.email                  = form.email;
    user.password               = form.password;
    user.password_confirmation  = form.password_confirmation;

    user.$save(function(u, responseHeaders) {
      $window.sessionStorage.token = responseHeaders().authorization;
      alert('Success user creation!');
      $location.path('/products');
    }, function(response){
      if(response.status == 500) {
        alert("Something is working wrong. Please try it later.");
        return;
      }

      if(response.status == 422) {
        var error = "Error to create the user. Please check the following errors: \n";

        angular.forEach(response.data.errors, function(e) {
          error += e + "\n";
        });

        alert(error);
      }
    });
  };

  $scope.signin = function(form) {
    var session = new Session();
    session.username               = form.username;
    session.password               = form.password;

    session.$save(function(session, responseHeaders) {
      $window.sessionStorage.token = responseHeaders().authorization;
      $location.path('/products');
    }, function(response) {
      if(response.status == 500) {
        alert("Some is working wrong. Please try it later.");
        return;
      }

      if(response.status == 422) {
        var error = "Error to sign in. Please check the following errors: \n";

        angular.forEach(response.data.errors, function(e) {
          error += e + "\n";
        });

        alert(error);
      }
    });
  };
}]);

EcommerceApp.controller('WelcomeController', ['$scope', function($scope) {
  $scope.message = 'Get all your favourites products with craziest prices.';
}]);

EcommerceApp.controller('ProductsController', ['$scope', 'Product', function($scope, Product) {
  $scope.message = 'Here should be the product list.';

  $scope.products = Product.query(function(data) {
  }, function(response) {
    alert("Error to list products");
  });
}]);
