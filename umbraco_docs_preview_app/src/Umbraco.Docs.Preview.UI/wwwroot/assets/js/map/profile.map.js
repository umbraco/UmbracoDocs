function initMap() {
    
    //Default position at Umbraco HQ
    var userPosition = {
        lat: 55.4063542,
        lng: 10.3862208
    }

    var createInitUserMarker = false;
    
    var currentLat = document.getElementById("Latitude").value;
    var currentLon = document.getElementById("Longitude").value;
    
    var mapObj = new google.maps.Map(document.getElementById('profile-map'),
        {
            zoom: 14,
            center: userPosition,
            mapTypeId: 'roadmap'
        });
    
    //Check we have something stored in hidden fields & valid numbers
    if ((currentLat.length > 0) || (currentLon.length > 0)) {

        if (isNaN(currentLat) === false || isNaN(currentLon) === false) {

            userPosition.lat = Number(currentLat);
            userPosition.lng = Number(currentLon);

            createInitUserMarker = true;

        } else {
            alert('bad data & not a number');

            //Lets clean up & set empty values in the hidden fields - so we dont carry on having rubbish data
            document.getElementById("Latitude").value = "";
            document.getElementById("Longitude").value = "";
        }
    }
    
    //Use the lat & lon of the user (stored location or the fallaback of HQ)
    mapObj.setCenter(userPosition);

    var marker = new google.maps.Marker({
        draggable: true
    });

    //The init marker add to the map or when its dragged will invoke us updating the hidden textboxes
    marker.addListener('position_changed', function () {

        var newPosition = marker.getPosition();
        document.getElementById("Latitude").value = newPosition.lat();
        document.getElementById("Longitude").value = newPosition.lng();
    });
    
    if (createInitUserMarker) {

        //We update the marker with the position & add it onto the map
        marker.setPosition(userPosition);
        marker.setMap(mapObj);
    }

    //Clear/remove marker button
    document.getElementById("remove-me").addEventListener("click", function () {
        document.getElementById("Latitude").value = "";
        document.getElementById("Longitude").value = "";
        marker.setMap(null);
    });


    //Geo locate me button
    document.getElementById("geolocate-me").addEventListener("click", function () {
        
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(geoPosition) {
                var pos = {
                    lat: geoPosition.coords.latitude,
                    lng: geoPosition.coords.longitude
                };

                //We don't explicitly set the input fields - as the marker event will trigger updating them
                marker.setPosition(pos);
                marker.setMap(mapObj);
                mapObj.setCenter(pos);

            },
            function() {
                alert('There was an error trying to find you. Perhaps you denied us permission?');
            });
        } else {
            alert('Your browser does not support HTML5 GeoLocation');
        }
    });
}
