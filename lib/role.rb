# roles have access to their associated object while the role's context is the current context.
module Role
  
  module ClassMethods # to extend role player objects
    
    # a role can find another role's player to send the object as an argument
    def player
      context.role_player[self]
    end

    private
      include ContextAccessor
      # allow role name to be used to reference the role's object
      def method_missing(method, *args, &block)
        super unless context && context.is_a?(my_context_class)
        if player.respond_to?(method)
          player.send(method, *args, &block)
        else # Neither a role method nor a valid player instance method
          super
        end
      end

      def role_name
        self.to_s.split("::").last
      end
      def my_context_class # a role is defined inside its context class
        self.to_s.chomp(role_name).constantize
      end
    end
  extend ClassMethods
end
