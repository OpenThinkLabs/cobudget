require 'faker'

### TIMEZONES

utc_offsets = [
  - 660, # hawaii
  - 600, # cook islands
  - 540, # alaska (anchorage)
  - 480, # california
  - 420, # colorado
  - 360, # costa rica
  - 300, # ecuador
  - 240, # brazil
  - 180, # uruguay
  - 120, # south sandwich islands
  -  60, # cape verde
  +   0, # ghana
  +  60, # france
  + 120, # finland
  + 180, # ethiopia
  + 240, # armenia
  + 300, # pakistan
  + 360, # bangladesh
  + 420, # cambodia
  + 480, # singapore
  + 540, # japan
  + 600, # australia, queensland
  + 660, # new caledonia
  + 720, # auckland
  + 780 # samoa
]

### USERS

admin = User.create(name: 'Admin', email: 'admin@example.com', password: 'P@ssw0rd10', utc_offset: -480, joined_first_group_at: DateTime.now.utc, is_super_admin: true) # oaklander
admin.confirm!
puts "generated confirmed admin account email: 'admin@example.com', password: 'P@ssw0rd10'"
non_admin = User.create(name: 'User', email: 'user@example.com', password: 'P@ssw0rd10', utc_offset: -480, joined_first_group_at: DateTime.now.utc) # oaklander
non_admin.confirm!
puts "generated confirmed user account email: 'user@example.com', password: 'P@ssw0rd10'"

users = []
utc_offsets.each do |utc_offset|
  user_genesis = DateTime.now.utc - rand(1..10).days
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'P@ssw0rd10',
    utc_offset: utc_offset,
    joined_first_group_at: DateTime.now.utc,
    created_at: user_genesis
  )
  user.confirm!
  users << user
end

puts "generated 27 more confirmed fake users"

### GROUPS

groups = []
2.times do
  group = Group.create!(name: Faker::Company.name, created_at: DateTime.now.utc - rand(1..10).days)
  group.add_admin(admin)
  group.add_member(non_admin)
  groups << group
end
puts "generated 2 fake groups"
puts "added admin and user accounts to both groups"

### MEMBERSHIPS

users.each do |user|
  groups.sample.add_member(user)
end
puts "added users as members to one of the groups"

### LIVE BUCKETS

groups.each do |group|
  rand(5..7).times do
    bucket = group.buckets.create(
      name: Faker::Lorem.sentence(1, false, 4),
      user: group.members.sample,
      description: Faker::Lorem.paragraph(3, false, 14),
      target: rand(0..1000),
      status: 'live',
      created_at: Time.zone.now - rand(1..10).days,
      live_at: Time.now.utc
    )
    rand(10).times { bucket.comments.create(user: group.members.sample, body: Faker::Lorem.sentence) }
  end
end
puts "created 5 - 7 live buckets for both groups with 0 - 9 comments"

### DRAFTS

groups.each do |group|
  rand(5..7).times do
    bucket = group.buckets.create(name: Faker::Lorem.sentence(1, false, 4),
                         user: group.members.sample,
                         description: Faker::Lorem.paragraph(3, false, 14),
                         target: [rand(0..4200), nil].sample,
                         status: 'draft',
                         created_at: Time.zone.now - rand(1..10).days)
    rand(10).times { bucket.comments.create(user: group.members.sample, body: Faker::Lorem.sentence) }
  end
end
puts "created 5 - 7 draft buckets for both groups with 0 - 9 comments"

### ARCHIVED_BUCKETS

groups.each do |group|
  rand(2..3).times do
    bucket = group.buckets.create(
      name: Faker::Lorem.sentence(1, false, 4),
      user: group.members.sample,
      description: Faker::Lorem.paragraph(3, false, 14),
      target: [rand(0..4200), nil].sample,
      status: "draft",
      archived_at: DateTime.now.utc,
      created_at: Time.zone.now - rand(1..10).days
    )
    rand(10).times { bucket.comments.create(user: group.members.sample, body: Faker::Lorem.sentence) }
  end
end
puts "created 2 - 3 archived draft buckets for both groups with 0 - 9 comments"

### FUNDED BUCKETS

groups.each do |group|
  rand(2..3).times do
    bucket = group.buckets.create(
      name: Faker::Lorem.sentence(1, false, 4),
      user: group.members.sample,
      description: Faker::Lorem.paragraph(3, false, 14),
      target: rand(0..1000),
      status: 'funded',
      created_at: Time.zone.now - rand(1..10).days,
      live_at: Time.now.utc,
      funded_at: Time.now.utc
    )
    rand(10).times { bucket.comments.create(user: group.members.sample, body: Faker::Lorem.sentence) }
  end
end
puts "created 2 - 3 funded buckets for both groups with 0 - 9 comments"


### ARCHIVED_FUNDED_BUCKETS (for legacy apps)

groups.each do |group|
  rand(2..3).times do
    bucket = group.buckets.create(
      name: Faker::Lorem.sentence(1, false, 4),
      user: group.members.sample,
      description: Faker::Lorem.paragraph(3, false, 14),
      target: [rand(0..4200)].sample,
      status: "funded",
      created_at: Time.zone.now - rand(1..10).days,
      live_at: Time.now.utc,
      funded_at: Time.now.utc
    )
    rand(10).times { bucket.comments.create(user: group.members.sample, body: Faker::Lorem.sentence) }
  end
end
puts "created 2 - 3 archived funded buckets for both groups with 0 - 9 comments"

### ALLOCATIONS

groups.each do |group|
  group.memberships.each do |membership|
    rand(1..4).times { 
      member = membership.member
      amount = rand(0.0..300)
      created_at = DateTime.now.utc - rand(1..100).days
      group.allocations.create(user: member, amount: amount, created_at: created_at)
      Transaction.create({
        datetime: created_at,
        created_at: created_at,
        from_account_id: membership.incoming_account_id,
        to_account_id: membership.status_account_id,
        user_id: admin.id,
        amount: amount
        })
    }
  end
end
puts "created 1 - 4 allocations for each member in each group"

### CONTRIBUTIONS

groups.each do |group|
  group.buckets.where(status: 'live').each do |bucket|
    rand(0..4).times do
      bucket_target = bucket.target
      membership = group.memberships.sample
      member = membership.member
      member_balance = membership.total_allocations - membership.total_contributions
      amount = (member_balance / 3).to_i
      created_at = DateTime.now.utc - rand(1..10).days
      bucket.contributions.create(user: member, amount: amount, created_at: created_at)
      Transaction.create({
        datetime: created_at,
        created_at: created_at,
        from_account_id: membership.status_account_id,
        to_account_id: bucket.account_id,
        user_id: member.id,
        amount: amount
        })
    end
  end
end

groups.each do |group|
  group.buckets.where(status: 'funded').each do |bucket|
    rand(0..4).times do
      bucket_target = bucket.target
      membership = group.memberships.sample
      member = membership.member
      member_balance = membership.total_allocations - membership.total_contributions
      amount = (member_balance / 3).to_i
      created_at = DateTime.now.utc - rand(1..10).days
      bucket.contributions.create(user: member, amount: amount, created_at: created_at)
      Transaction.create({
        datetime: created_at,
        created_at: created_at,
        from_account_id: membership.status_account_id,
        to_account_id: bucket.account_id,
        user_id: member.id,
        amount: amount
        })
    end
    bucket.update(archived_at: DateTime.now.utc)
  end
end

puts "created 0 - 4 contributions for each live and funded bucket in each group"

puts 'Seed: Complete!'
