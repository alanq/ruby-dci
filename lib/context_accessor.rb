# Defines only the context getter, as this module is included in both Roles and Context
# Context should define the equivalent setter
module ContextAccessor
  def context
    Thread.current[:context]
  end
end
