crumb :root do
  link "Home", root_path
end

crumb :user_show do
  link "マイページ", user_path
end

crumb :item_new do
  link "出品", new_item_path
end

crumb :item_show do
  link "商品詳細", item_path
end

crumb :item_edit do
  link "商品編集",edit_item_path
  parent :item_show
end

crumb :item_search do
  link "商品検索",tag_search_items_path

end