Deface::Override.new(virtual_path: 'spree/admin/products/index',
  name: 'add_csv_import_to_product_index',
  insert_after: "erb[loud]:contains('button_link_to')",
  text: "
      <h3 id='demo'>Test test</h3>
      <%= form_tag import_products_path, multipart: true do %>
        <%= file_field_tag :file, id: 'uploadCSV'  %>
        <%= submit_tag 'Import products from CSV', { class: 'btn-success', icon: 'add', id: 'admin_new_product' } %>
      <% end %> 

      <%= javascript_include_tag'papaparse.min.js', 'data-turbolinks-track' =>'reload' %>

  <script>

  var inputCSV =  document.getElementById('uploadCSV');
      var required_attributes = ['name', 'shipping_category_id', 'price'];

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

  function validation_alert(values, headers, required_attributes) {
    if ( validate_headers(headers, required_attributes)) {
      var invalid_products_data = validateProducts(values, required_attributes);
      if ( invalid_products_data == 0) {
        alert('Products impoerted!');
      } else {
        alert(invalid_products_data + ' fields have invalid data');
      }
    } else {
      alert('File headers are invalid!');
    }
  }

  function validate_headers(headers, required_attributes) {
    for (var i = 0; i < required_attributes.length-1; i++) {
      if ( !(headers.includes(required_attributes[i]))) {
        return false;
      }
    } return true;
  }

  function validateProducts(values, required_attributes) { 
    var invalid_data = 0;
    var invalid_products = Array.new;
    for(var i = 0; i < values.length-1; i++) { 
      for (var j = 0; j < required_attributes.length; j++) {
        if (values[i][required_attributes[j]] === null ) {
          invalid_data++;
        }
      }
    } return invalid_data;
  } 

  </script>
  ")