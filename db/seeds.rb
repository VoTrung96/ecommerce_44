Category.create!(name: "Men's Shoe",
                parent_id: 0)

Product.create!(category_id: 1,
                name: "Adidas",
                summary: "Summer shoe",
                price: 2,
                quantity: 3)
59.times do |n|
  name = Faker::Name.name
  price =   n
  quantity = n
  Product.create!(category_id: 1,
                name: name,
                summary: "Summer shoe",
                price: price,
                quantity: quantity)
end
