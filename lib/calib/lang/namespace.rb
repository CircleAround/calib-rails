module Calib
  module Lang
    # == A Class for Namespace
    class Namespace
      # array of Modlules of _cls_ 
      def self.as_modules(cls, array = [])
        parent = cls.parent
        return array if parent == Object
        as_modules(parent, array.unshift(parent))
      end

      # array of Symbols of _cls_ 
      def self.as_symbols(cls)
        # @see https://stackoverflow.com/questions/133357/how-do-you-find-the-namespace-module-name-programmatically-in-ruby-on-rails
        as_modules(cls).map {|ns| ns.to_s.demodulize.underscore.to_sym }
      end
    end
  end
end