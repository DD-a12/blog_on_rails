PASSWORD = "supersecret"  
 
Comment.delete_all 
Post.delete_all 
User.delete_all 

super_user = User.create( 
    first_name: "Jon", 
    last_name: "Snow", 
    email: "js@winterfell.gov",
    password: PASSWORD,
    is_admin: true
) 

10.times do 
    first_name = Faker::Name.first_name 
    last_name = Faker::Name.last_name 
    User.create( 
        first_name: first_name, 
        last_name: last_name,  
        email: "#{first_name.downcase}.#{last_name.downcase}@example.com", 
        password: PASSWORD 
    )  
end 

users = User.all 
puts Cowsay.say("Created #{users.count} users", :tux)  
 
puts "Login with #{super_user.email} and password of '#{PASSWORD}'"

200.times do
    user = users.sample 
    p = Post.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::ChuckNorris.fact,
        created_at: Faker::Date.backward(days:365 * 5),
        updated_at: Faker::Date.backward(days:365 * 5),
        user_id: user.id
    )
    if p.valid?
        p.comments = rand(0..15).times.map do
            user = users.sample
            Comment.new(body: Faker::GreekPhilosophers.quote, user_id: user.id)
        end
    end
end

puts Cowsay.say("Generated #{Post.count} Post", :frogs)
puts Cowsay.say("Generated #{Comment.count} Comment", :tux)