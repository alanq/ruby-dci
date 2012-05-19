module Context
  include ContextAccessor

  attr_reader :role_player # allows a role to find its player

  # Context setter is defined here so it's not exposed to roles (via ContextAccessor)
  def context=(ctx)
    Thread.current[:context] = ctx
  end

  # sets the current global context for access by roles in the interaction
  def execute_in_context
    old_context = self.context
    self.context = self
    return_object = yield
    self.context = old_context
    return_object
  end

end # class Context
