import mapboxgl from 'mapbox-gl';

const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/leovenom/ck7fc3y920oz91il4r4nygfrw'
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      const element = document.createElement('div');
      console.log(`url('${marker.image_url}')`)
        element.className = 'marker';
        element.style.backgroundImage = `url('${marker.image_url}')`;
        element.style.backgroundSize = 'contain';
        element.style.width = '30px';
        element.style.height = '30px';

    new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
};

const getMarkers = (e) => {
  console.log("oi", mapElement.dataset.markers)
  console.log("el", e)
  const marker = [{
    lng: e.getAttribute('data-logitude'),
    lat: e.getAttribute('data-latitude'),
    image_url: e.getAttribute('data-image'),
    infoWindow: e.getAttribute('data-info')
    }]


  return marker
};

const reInitMapbox = (marker) => {
  const mapElement = document.querySelector("#map")
  if (mapElement) {
    const map = buildMap();
    addMarkersToMap(map, marker);
    fitMapToMarkers(map, marker);
  }
};

const updateMap = () => {
   const buttons = document.querySelectorAll(".location_btn")
   buttons.forEach(button => {
    button.addEventListener("click", function() {
      const marker = getMarkers(this)
      console.log(getMarkers(this))
      reInitMapbox(marker)

    })
   })
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 10, maxZoom: 15 });
};

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers)
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
};


export { initMapbox };
export { updateMap };
