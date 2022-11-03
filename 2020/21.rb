input_file = File.read('./21.input').split "\n"

foods = input_file.map { |l| l.split(' (contains')[0].split ' ' }
allergens = input_file.map { |l| l.split(' (contains ')[1][..-2].split ', ' }

f_a_mapping = {}
(0...foods.size).each do |i|
  foods[i].each do |food|
    f_a_mapping[food] ||= []
    f_a_mapping[food] += allergens[i]
  end
end

f_a_mapping.each do |k, v|
  f_a_mapping[k] = v.inject(Hash.new(0)) { |h, e| h[e] += 1; h }
end

most_probable = []
foods.each_with_index do |food_list, i|
  most_probable << {}
  food_list.each do |food|
    allergens[i].map do |allergen|
      most_probable[i][allergen] ||= [food, f_a_mapping[food][allergen]]
      if most_probable[i][allergen][1] < f_a_mapping[food][allergen]
        most_probable[i][allergen] = [food, f_a_mapping[food][allergen]]
      end
    end
  end
end

allergic_foods = most_probable.map { |el| el.map { |_, v| v[0] } }.flatten.uniq

total = 0
foods.each do |food_list|
  food_list.each do |food|
    total += 1 unless allergic_foods.include? food
  end
end

pp total

by_allergen = {}
most_probable.each do |allergen_group|
  allergen_group.each do |k, v|
    by_allergen[k] ||= []
    by_allergen[k] << v[0]
  end
end

by_allergen.values.map(&:uniq!)

filtered = []
loop do
  products_to_delete = by_allergen.values.select { |v| v.size == 1 }
  product_to_delete = nil
  products_to_delete.each do |r|
    next if filtered.include? r.first

    filtered << r.first
    product_to_delete = r.first
    break
  end
  break if product_to_delete.nil?

  by_allergen.values.select { |r| r.size > 1 }.each do |product|
    product.delete product_to_delete
  end
end

pp by_allergen.sort_by { |k, _| k }.map { |p| p.last.first }.join ','
