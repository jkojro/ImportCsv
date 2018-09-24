Deface::Override.new(virtual_path: 'spree/admin/products/index',
  name: 'add_csv_import_to_product_index',
  insert_after: "erb[loud]:contains('button_link_to')",
  text: "
      <%= form_tag import_products_path, multipart: true do %>
      <%= file_field_tag :file %>
      <%= submit_tag 'Import products from CSV', { class: 'btn-success', icon: 'add', id: 'admin_new_product' } %>
    <% end %>
  ")