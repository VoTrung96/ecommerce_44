Category.create!(name: "Men's Shoe",
                parent_id: 0)

Product.create!(category_id: 1,
                name: "Adidas",
                summary: "Summer shoe",
                price: 2,
                quantity: 3)
59.times do |n|
  name = Faker::Name.name
  price =   n + 1
  quantity = n
  Product.create!(category_id: 1,
                name: name,
                summary: name,
                price: price,
                quantity: quantity)
  4.times do |m|
    Image.create!(product_id: n + 1,
                name: "shoe-detail/1.jpg")
  end
end
