class ShoppingBasket
  def initialize(items)
    @basket = items
  end

  def total
    discount_sets.inject(0) { |sum, set| sum + discount_set_total(set) }.round(2)
  end

  private

  def discount_sets
    sets = discount_sets_from_basket

    if better_discounts_available(sets)
      better_discount_sets(sets)
    else
      sets
    end
  end

  def discount_sets_from_basket
    sets = []
    items = @basket.clone.sort_by { |item| item.to_s }

    while items.size > 0
      sets << biggest_discount_set_from_items(items).each do |item|
        items.delete_at(items.index(item))
      end
    end

    sets
  end

  def better_discount_sets(sets)
    sets_of_3 = discount_sets_of_size(3, sets)
    sets_of_5 = discount_sets_of_size(5, sets)

    better_discounts_available(sets).times do |index|
      sets_of_3[index].push(sets_of_5[index].pop)
    end

    sets
  end

  def biggest_discount_set_from_items(items)
    items.uniq { |item| item.to_s }.sort_by { |item| item.to_s }
  end

  def better_discounts_available(sets)
    [discount_set_size_count(3, sets), discount_set_size_count(5, sets)].min
  end

  def discount_set_size_count(size, sets)
    sets.count { |set| set.size == size }
  end

  def discount_sets_of_size(size, sets)
    sets.select { |set| set.size == size }
  end

  def discount_set_total(set)
    set_total(set) * discount_rate(set.size)
  end

  def set_total(set)
    set.inject(0) { |sum, item| sum + item.price }
  end

  def discount_rate(count)
    (100 - discount_rates.fetch(count, 0)) / 100.0
  end

  def discount_rates
    {
      2 => 5,
      3 => 10,
      4 => 20,
      5 => 25,
    }
  end
end
