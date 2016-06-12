require 'mongoid/object/version'

module Mongoid
  module Object
    autoload :Document, 'mongoid/object/document'
    autoload :Dynamic, 'mongoid/object/dynamic'
    autoload :Worker, 'mongoid/object/worker'
  end
end
