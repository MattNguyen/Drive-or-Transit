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

unless File.exists?('db/bart_drive.sqlite3')
  puts 'creating database...'
  ActiveRecord::Schema.define do
      create_table :users do |t|
        t.column :first_name, :string, :null => false
        t.column :last_name, :string, :null => false
      end

      create_table :addresses do |t|
        t.column :street, :string
        t.column :city, :string
        t.column :state, :string
        t.column :zip, :string
        t.column :created_at, :datetime, :default => 'CURRENT_TIMESTAMP'
        t.column :user_id, :integer, :null => false
      end
  end
end
