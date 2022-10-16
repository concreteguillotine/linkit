unless User.exists?(username: "admin")
    User.create!(username: "admin", email: "admin@margemporium.com", password: "password", admin: true)
end

unless User.exists?(username: "user")
    User.create!(username: "user", email: "user@margemporium.com", password: "password", admin: false)
end
