/// <reference path="../angular.min.js" />

$(function () {
    
    //$("#tbSearch").on('blur', function (e) {
    //    var self = $(this);

    //    if(self.val())
    //    var address = $.trim(self.val()) + ',+India';
    //    getLocation.done(function (response) {
    //        if (response.status == "ZERO_RESULTS") {
    //            console.log('No Exact Address Matches');
    //            $("#divSuggestedArea").text('No Exact Address Matches');
    //        } else if (response.results.length > 0) {
    //            console.log(JSON.stringify(response));
    //            $("#divSuggestedArea").text(response.results[0].formatted_address);
    //        }

    //    });
        
    //});
    
    
    $("#tbSearch").on('keyup', function (e) {
        if (e.keyCode == 32) {
            var searchKeyword = $.trim($(this).val());
            getSearchResult(searchKeyword).done(function (response) {
                switch (response.status) {
                    case "OK":
                        $("#divNoResultFound").hide();
                        $("#divResult").show();
                        showResult(response.results);
                        break;
                    case "ZERO_RESULTS":
                        $("#divNoResultFound").text("No Results Found :(");
                        $("#divResult").hide();
                        break;
                    case "OVER_QUERY_LIMIT":
                        $("#divResult").hide();
                        $("#divNoResultFound").text("API OverLoaded");
                        break;
                    case "REQUEST_DENIED":
                        $("#divResult").hide();
                        $("#divNoResultFound").text("Request Denied");
                        break;
                    case "INVALID_REQUEST":
                        $("#divResult").hide();
                        $("#divNoResultFound").text("Invalid Request");
                        break;
                    default:
                        alert('Unknown Responce by google api');
                }
                if (response.status == "ZERO_RESULTS") {
                    console.log('No Exact Result Matches');
                } else if(response.results.length > 0) {
                    console.log(JSON.stringify(response));
                    $("#divSuggestedArea").text(response.results[0].formatted_address);
                }
            });
        }
    });
    //initialize();
});

var basePhotoUrl = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&maxheight=400&photoreference=";

//Get the location(along with longitude and latitude) returned by the google geocode api for that address
var getLocation = function(address) {
    return $.ajax({
        url: 'https://maps.googleapis.com/maps/api/geocode/json',
        type: "GET",
        crossDomain: true,
        data: { 'address': address, 'key': 'AIzaSyCXBHLT0uUueX3zlQspveSoSmCtU4RkECc' },
        dataType: "json",
        success: function(data) {
        },
        error: function(error) {
            alert('Google api error : ' + JSON.stringify(error));
        }

    });
}


// Get the search result by the google
var getSearchResult = function (keyword) {
    return $.ajax({
        url: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
        type: "GET",
        crossDomain: true,
        data: { 'query': keyword, 'key': 'AIzaSyDsPNyQHNRyVMVNT3udi59NJM_FAvTcDiA' },
        success: function (data) {
        },
        error: function (error) {
            alert('Google api error : ' + JSON.stringify(error));
        }

    });
}


var helper = {};
helper.isNullOrEmpty = function(item) {
    return (item == undefined || item == null || $.trim(item) == "");
}

var map;
var service;
var infowindow;

function initialize() {
    var pyrmont = new google.maps.LatLng(-33.8665433, 151.1956316);

    map = new google.maps.Map(document.getElementById('map'), {
        center: pyrmont,
        zoom: 15
    });

    var request = {
        location: pyrmont,
        //radius: '5000',
        query: 'restaurant'
    };

    service = new google.maps.places.PlacesService(map);
    service.textSearch(request, callback);
}

function callback(results, status) {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
        
        var template = "";
        $("#divResult").text("").show();

        $.each(results, function (index, item) {
            if (item.photos.length > 0) {
                template = "<div class='col-md-4'>" +
                "<img src='" + item.photos[0].getUrl({ 'maxWidth': 400, 'maxHeight': 400 }) + "'>" +
                "</div>";
                $("#divResult").append(template);
            }
            
            template = "";
            console.log(item);
        });
    }
}


//var app = angular.module('myApp', []);
//app.controller('searchController', [
//    '$scope', '$http', function($scope, $http) {
//        $scope.records = [
//            "Alfreds Futterkiste",
//            "Berglunds snabbköp",
//            "Centro comercial Moctezuma",
//            "Ernst Handel"
//        ];
//        //$scope.pyrmont = new google.maps.LatLng(-33.8665433, 151.1956316);

//        //$scope.map = new google.maps.Map(document.getElementById('map'), {
//        //    center: $scope.pyrmont,
//        //    zoom: 15
//        //});

//        //var request = {
//        //    location: pyrmont,
//        //    //radius: '5000',
//        //    query: 'restaurant'
//        //};

//        //$scope.service = new google.maps.places.PlacesService($scope.map);
//        //$scope.service.textSearch(request, function(results, status) {
//        //    console.log(results);
//        //    if (status == google.maps.places.PlacesServiceStatus.OK) {
//        //        $scope.results = results;
//        //    }
//        //});

//    }
//]);


var app = angular.module('myApp', []);

app.service('Map', function ($q) {

    this.init = function () {
        var options = {
            center: new google.maps.LatLng(40.7127837, -74.00594130000002),
            zoom: 13,
            disableDefaultUI: true
        }
        this.map = new google.maps.Map(
            document.getElementById("map"), options
        );
        this.places = new google.maps.places.PlacesService(this.map);
    }

    this.search = function (str) {
        var d = $q.defer();
        this.init();
       
        this.places.textSearch({ query: str }, function (results, status) {
            if (status == 'OK') {
                d.resolve(results);
            }
            else d.reject(status);
        });
        return d.promise;
    }

    //this.addMarker = function (res) {
    //    if (this.marker) this.marker.setMap(null);
    //    this.marker = new google.maps.Marker({
    //        map: this.map,
    //        position: res.geometry.location,
    //        animation: google.maps.Animation.DROP
    //    });
    //    this.map.setCenter(res.geometry.location);
    //}

});

app.controller('searchController', function ($scope, Map) {

    $scope.results = [];
    $scope.search = function () {
        $scope.apiError = false;
        Map.search($scope.searchKeyword)
        .then(
            function (res) { // success
                //Map.addMarker(res);
                //$scope.place.name = res.name;
                //$scope.place.lat = res.geometry.location.lat();
                //$scope.place.lng = res.geometry.location.lng();
                $scope.results = res;
                console.log(res);
            },
            function (status) { // error
                $scope.apiError = true;
                $scope.apiStatus = status;
            }
        );
    }

    Map.init();
});
