import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static targets = ["autocomplete", "streetNumber", "route", "locality", "administrativeArea", "country", "postalCode"];

  connect() {
    console.log("Address Autocomplete Controller connected");
    this.autocomplete = new google.maps.places.Autocomplete(this.autocompleteTarget, {
      types: ['geocode']
    });

    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this));
  }

  placeChanged() {
    const place = this.autocomplete.getPlace();
    const components = place.address_components || [];

    components.forEach(component => {
      const addressType = component.types[0];
      switch (addressType) {
        case 'street_number':
          this.streetNumberTarget.value = component.long_name;
          break;
        case 'route':
          this.routeTarget.value = component.long_name;
          break;
        case 'locality':
          this.localityTarget.value = component.long_name;
          break;
        case 'administrative_area_level_1':
          this.administrativeAreaTarget.value = component.short_name;
          break;
        case 'country':
          this.countryTarget.value = component.long_name;
          break;
        case 'postal_code':
          this.postalCodeTarget.value = component.long_name;
          break;
      }
    });
  }
}
