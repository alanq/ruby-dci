# A role contains only class methods and can not be instantiated.

# Although role methods are implemented as public class methods, they only have
# access to their associated object while the role's context is the current context.
class Role

  def initialize
    raise "A Role should not be instantiated"
  end

  class << self
    protected
      include ContextAccessor

      def role_name
        self.to_s.split("::").last
      end
      def my_context_class # a role is defined inside its context class
        self.to_s.chomp(role_name).constantize
      end
      def player
        context.role_player[self]
      end
      # allow player instance methods be called on the role's self
      def method_missing(method, *args, &block)
        super unless context && context.is_a?(my_context_class)
        if player.respond_to?(method)
          player.send(method, *args, &block)
        else # Neither a role method nor a valid player instance method
          super
        end
      end
  end
end
