# There are gems for this, but figured I'd just make a method here
def create_random_string
  ('a'..'z').to_a.shuffle[0,8].join
end

# Creating non-shipped orders.
puts '***** Creating non-shipped Orders *****'
5.times { Order.create! }

# Shipped at times are randomly assigned.  What great randomizaiton I've done!
puts '***** Creating shipped Orders *****'
5.times { Order.create!(shipped_at: Time.now+rand(10000)) }

puts '***** Creating Widgets *****'
10.times { Widget.create!(name: create_random_string, msrp: rand(100)) }

puts "***** Done! #{Order.count} orders were created. #{Widget.count} Widgets were created. *****"
