
  function csv_validation(inputCSV, required_attributes) {
    inputCSV.onchange = function(event) {
      var files = inputCSV.files;
      var file = files[0];

      Papa.parse(file, {
        header: true,
        dynamicTyping: true,
        complete: function(results) {
          data = results;
          var values = data.data
          var headers = Object.keys(values[0]);
          validation_alert(values, headers, required_attributes);
        }
      });
    }
  }

  function validation_alert(values, headers, required_attributes) {
    if ( validate_headers(headers, required_attributes)) {
      var invalid_products_data = validateProducts(values, required_attributes);
      if ( invalid_products_data == 0) {
        alert('File is validated.');
      } else {
        alert(invalid_products_data + ' fields have invalid data');
      }
    } else {
      alert('File headers are invalid!');
    }
  }

  function validate_headers(headers, required_attributes) {
    for (var i = 0; i < required_attributes.length; i++) {
      if ( !(headers.includes(required_attributes[i]))) {
        return false;
      }
    } return true;
  }

  function validateProducts(values, required_attributes) { 
    var invalid_data = 0;
    var invalid_products = Array.new;
    for(var i = 0; i < values.length; i++) { 
      for (var j = 0; j < required_attributes.length-1; j++) {
        if (values[i][required_attributes[j]] === null ) {
          invalid_data++;
        }
      }
    } return invalid_data;
  } 