var geocoder, location1, location2, gDir;

function displayDuration(seconds) {
    var days, hours, minutes, ret="", days_str="", hours_str="", minutes_str="";
    days    = seconds / (24*60*60);
    hours   = (seconds % (24*60*60)) / (60*60);
    minutes = ((seconds % (24*60*60)) % (60*60)) / 60

    if (Math.floor(days) > 0) {
        var post="";
        if (Math.floor(days) == 1) {
            post=" day "
        }
        else {
            post=" days "
        }
        days_str=days_str.concat(Math.floor(days).toString(), post);
    }
    if (Math.floor(hours) > 0) {
        var post = "";
        if (Math.floor(hours) == 1) {
            post = " hour ";
        }
        else {
            post = " hours ";
        }
        hours_str=hours_str.concat(Math.floor(hours).toString(), post);
    }
    if (Math.floor(minutes) > 0) {
        var post = "";
        if (Math.floor(minutes) == 1) {
            post = " minute ";
        }
        else {
            post = " minutes ";
        }
        minutes_str=minutes_str.concat(Math.floor(minutes).toString(), post);
    }
    if ((days_str == "") && (hours_str == "") && (minutes_str == "")) {
        ret = ret.concat("less than 1 minute");
    }
    else {
       ret=ret.concat(days_str, hours_str, minutes_str);
    }
    return ret;
}

function initialize() {
    geocoder = new GClientGeocoder();
    gDir = new GDirections();
    GEvent.addListener(gDir, "load", function() {
        var drivingDistanceMiles = gDir.getDistance().meters / 1609.344;
        var drivingDistanceKilometers = gDir.getDistance().meters / 1000;
        var drivingTime = displayDuration(gDir.getDuration().seconds);
        var route_notes = location1.address + ' (' + location1.lat + ':' + location1.lon + ')' + ' to ' + location2.address + ' (' + location2.lat + ':' + location2.lon + ')\nDriving Distance: ' + drivingDistanceMiles + ' miles' + '\nDriving Time: ' + drivingTime;
        //document.getElementById('results').innerHTML = '<strong>Address 1: </strong>' + location1.address + ' (' + location1.lat + ':' + location1.lon + ')<br /><strong>Address 2: </strong>' + location2.address + ' (' + location2.lat + ':' + location2.lon + ')<br /><strong>Driving Distance: </strong>' + drivingDistanceMiles + ' miles (or ' + drivingDistanceKilometers + ' kilometers)' + '<br /><strong>Driving Time:</strong> ' + drivingTime;
        var str1=""
        var str2="";
        document.getElementById('driving_distance').value=drivingDistanceMiles.toFixed(2);
        document.getElementById('route_notes').value=route_notes;
        document.getElementById('update_comment').innerHTML="click Update below to save this information"
        //document.getElementById("location1_name").innerHTML=self.location1.address;
        //document.getElementById("location2_name").innerHTML=self.location2.address;
        //document.getElementById("location1_coord").innerHTML=str1.concat(" (", self.location1.lat, ",",  self.location1.lon, ")");
        //document.getElementById("location2_coord").innerHTML=str2.concat(" (", self.location2.lat, "," , self.location2.lon, ")");
        //document.getElementById("driving_distance")=drivingDistanceMiles.toFixed(2);  
        //document.getElementById("driving_duration").innerHTML=drivingTime;
    });
}

function showLocation(address1, address2) {
    initialize();
    geocoder.getLocations(address1, function (response) {
        if (!response || response.Status.code != 200)
        {
            alert("Sorry, we were unable to geocode the first address");
        }
        else
        {
            location1 = {lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address};
            geocoder.getLocations(address2, function (response) {
                if (!response || response.Status.code != 200)
                {
                    alert("Sorry, we were unable to geocode the second address");
                }
                else
                {
                    location2 = {lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address};
                    gDir.load('from: ' + location1.address + ' to: ' + location2.address);
                }
            });
        }
    });
}