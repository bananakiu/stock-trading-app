# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
roles = Role.create([
    {name: "member"},
    {name: "admin"}
])

# TODO: encrypt
admin = User.create(
    email: "admin@admin.com",
    password: "password",
    approved: true # admin is automatically approved
)

admin.skip_confirmation! # no need to confirm admins
admin.roles << Role.find_by_name("admin")
admin.confirm
admin.save