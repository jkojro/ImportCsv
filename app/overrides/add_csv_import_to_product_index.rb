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
      <%= javascript_include_tag'csv_validation.js', 'data-turbolinks-track' =>'reload' %>

  <script>
    var inputCSV =  document.getElementById('uploadCSV');
    var required_attributes = ['name', 'shipping_category_id', 'price'];
    csv_validation(inputCSV, required_attributes);
  </script>
  ")