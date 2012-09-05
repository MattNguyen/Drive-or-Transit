require 'active_record'
require 'uri'

db = URI.parse(ENV['DATABASE_URL'] || 'sqlite3://localhost/db/bart_drive.sqlite3')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :port     => db.port,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

unless db.scheme == 'postgres' || File.exists?('db/bart_drive.sqlite3')
  puts 'creating database...'
  ActiveRecord::Schema.define do
      create_table :users do |t|
        t.string :first_name, :null => false
        t.string :last_name, :null => false
      end

      create_table :addresses do |t|
        t.string   :street
        t.string   :city
        t.string   :state
        t.string   :zip
        t.datetime :created_at, :null => false
        t.integer  :user_id, :null => false
      end
  end
end
