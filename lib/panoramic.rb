require 'panoramic/resolver'
if defined?(Mongoid)
  require 'panoramic/orm/mongoid'
elsif defined?(ActiveRecord)
  require 'panoramic/orm/active_record'
end
