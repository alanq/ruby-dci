# roles have access to their associated object while the role's context is the current context.
module Role
  module ClassMethods
    include ContextAccessor

    # returns the player as the substitute for an unrecognised constant that is the role name
    def player
      context.role_player[self]
    end

    # allow player object instance methods be called on the role's self
    def method_missing(method, *args, &block)
      super unless context && context.is_a?(my_context_class)
      if player.respond_to?(method)
        player.send(method, *args, &block)
      else # Neither a role method nor a valid player instance method
        super
      end
    end

    private
      def role_name
        self.to_s.split("::").last
      end
      def my_context_class # a role is defined inside its context class
        self.to_s.chomp(role_name).constantize
      end
  end
  extend ClassMethods
end
