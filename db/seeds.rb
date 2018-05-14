Category.create!(name: "Men's Shoe",
                parent_id: 0)
Category.create!(name: "Women's Shoe",
                parent_id: 0)
Category.create!(name: "Sport Shoe",
                parent_id: 1)
Category.create!(name: "Spring Shoe",
                parent_id: 2)

60.times do |n|
  name = Faker::Name.name
  price = Random.rand(10..20)
  quantity = Random.rand(10..20)
  Product.create!(category_id: Random.rand(1..4),
                name: name,
                summary: name,
                price: price,
                quantity: quantity)
end
