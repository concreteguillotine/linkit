
unless User.exists?(username: "user")
    user = User.create!(
        username: "user", 
        email: "user@linkit.com", 
        password: "password",
        admin: false)
end

unless User.exists?(username: "admin")
    adminseth = User.create!(
        username: "admin", 
        email: "admin@linkit.com", 
        password: "password", 
        admin: true)
end

Tag.destroy_all

# meme = Tag.create!(
#     { name: "meme" })
# image = Tag.create!(   
#     { name: "image" })
# video = Tag.create!(
#     { name: "video" })
# link = Tag.create!(
#     { name: "link" })
# text = Tag.create!(
#     { name: "text" })
# news = Tag.create!(
#     { name: "news" })
# music = Tag.create!(
#     { name: "music" })
# question = Tag.create!(
#     { name: "question" })
# webdev = Tag.create!(
#     { name: "webdev" })
# html = Tag.create!(
#     { name: "html" })
# cats = Tag.create!(
#     { name: "cats" })

tags = [ "meme", "image", "cats", "video", 
         "link", "text", "news", "music", 
         "question", "webdev", "html", "animals" ]

tags.each do |tag|
    Tag.create!(name: tag)
end

Post.destroy_all

post1 = Post.create!(
        name: "Amazing and true meme",
        author: User.find_by(username: "admin"),
        text: "What do you guys think?",
        tags: Tag.where(name: "meme")
        )

        post1.image.attach(io: File.open(Rails.root.join("public/images/margotmeme.jpg")), filename: "margotmeme.jpg")

post2 = Post.create!(
        name: "Hawk in my backyard",
        author: User.find_by(username: "user"),
        text: "Saw a hawk this morning, spooky stuff",
        tags: Tag.where(name: "image")
        )

        post2.image.attach(io: File.open(Rails.root.join("public/images/hawk.jpg")), filename: "hawk.jpg")

post3 = Post.create!(
        name: "Donec ac ultricies leo. Vestibulum in tincidunt urna. Ut turpis?",
        author: User.find_by(username: "admin"),
        text: "Ut pellentesque tempor lorem sit amet interdum. Praesent quis semper erat, a feugiat nibh. Sed blandit risus quis iaculis efficitur?",
        tags: Tag.where(name: "text")
        )

post4 = Post.create!(
        name: "Nunc id ullamcorper lorem. Nunc nec efficitur erat. Ut nec ipsum sit.",
        author: User.find_by(username: "user"),
        text: "Vivamus mattis purus vestibulum erat faucibus, in viverra leo facilisis. 
        Maecenas odio lorem, dapibus et suscipit ut, venenatis sit amet neque. 
        Curabitur sollicitudin justo sed semper hendrerit. Sed in porttitor nisi. 
        Praesent cursus quam at tellus pulvinar tincidunt. Morbi pharetra nisi id elit congue blandit. 
        Nulla rhoncus mi ut neque aliquam bibendum. Praesent nec enim ac augue blandit hendrerit tempor non libero. 
        Aliquam vitae lectus ut diam viverra tempor. ",
        tags: Tag.where(name: "question")
        )

post5 = Post.create!(
        name: "A handy website that allows you to generate lorem ipsum text.",
        author: User.find_by(username: "admin"),
        url: "https://www.lipsum.com/feed/html",
        text: "Check it out:
        Praesent augue nibh, tempus eget dictum quis, semper sit amet tortor. 
        Sed libero ante, malesuada vitae accumsan eu, tempor eget tortor. 
        In in laoreet orci. Vivamus nisl magna, vestibulum non gravida vitae, posuere sed diam. 
        Nulla ornare ipsum lectus, eu sagittis mi tincidunt vel. 
        Etiam elementum, orci ac sagittis mollis, sem nisi hendrerit magna, nec consectetur est nisl et risus.",
        tags: Tag.where(name: "link")
        )

post6 = Post.create!(
        name: "Free course for learning the basics of HTML!",
        author: User.find_by(username: "user"),
        url: "https://www.codecademy.com/learn/learn-html",
        text: "Start at the beginning by learning HTML basics — an important foundation for building and editing web pages.",
        tags: Tag.where(name: "html")
        )

post7 = Post.create!(
        name: "Any tips on improving my github account for getting my first junior developer position?",
        author: User.find_by(username: "user"),
        url: "https://github.com/concreteguillotine",
        text: "As you can see, I enjoy building projects with Rails",
        tags: Tag.where(name: "question")
        )

post8 = Post.create!(
        name: "Grocery store inadvertently open on Family Day",
        author: User.find_by(username: "admin"),
        url: "https://www.kingstonist.com/news/grocery-store-inadvertently-open-on-family-day/",
        text: "Store in Canada accidentally left their doors open during a holiday, nothing was stolen or damaged.",
        tags: Tag.where(name: "news")
        )

post9 = Post.create!(
        name: "Radiohead - All I Need (Scotch Mist)",
        author: User.find_by(username: "user"),
        youtubeurl: "https://www.youtube.com/watch?v=ioPDGJIf2QI",
        text: "One of my favorite songs ever.",
        tags: Tag.where(name: "music")
        )

post10 = Post.create!(
        name: "The latest CS50 course from 2022",
        author: User.find_by(username: "admin"),
        youtubeurl: "https://www.youtube.com/watch?v=IDDmrzzB14M",
        text: "Highly recommended for those starting out their programming journeys!",
        tags: Tag.where(name: "video")
        )